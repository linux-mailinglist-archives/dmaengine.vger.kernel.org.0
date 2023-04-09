Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35786DC202
	for <lists+dmaengine@lfdr.de>; Mon, 10 Apr 2023 01:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDIXeA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Apr 2023 19:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIXd7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Apr 2023 19:33:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240783595
        for <dmaengine@vger.kernel.org>; Sun,  9 Apr 2023 16:33:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t14so4446419lft.7
        for <dmaengine@vger.kernel.org>; Sun, 09 Apr 2023 16:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681083236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmWyTtqXagmJ+EkdgpkYkNzA/ON4CgrTaGNlpRFCRVk=;
        b=K3fQ+IUfklflf52cmwFwjdiSg5vkh0CtJmPEiL793fhb13Zgd2N4SlO9Cl195RFLAo
         OdqPj1Z9lIDWv7m7XDzejQ78mcnUSVr2mxRleX29i1oXovL/m2+2Bh4Hx0ah8KR7XSKi
         tGQEO46p1Vffykaqa6LQHJyIn6RYxLvuIsZoPwhjMTHdv+cj0Cj/c34Cvc0ON0X3CYbg
         y+6yh0JMGWITy0VgqiFedDMJPhSnNGxLO/uBZnfVW80cl8z1MHSRh90LxZwP4mT3FT+Y
         DQUf+50MV7TJn0RLeDttgQe6lPv++SsMTE9tWhL1F1w3KbNvUOJoJdhVrHnWYTOMg4YT
         rtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681083236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmWyTtqXagmJ+EkdgpkYkNzA/ON4CgrTaGNlpRFCRVk=;
        b=FpM2dKn7llZ6LHxaq1/4Ad/kWmSyi2MQDFBLzhwIfaoYaUbWYD7QMxblAU1UYXQGWs
         BfhoOxpa2h/9r40p3xiYmgFliDTigg1JtzuCs1b4aZ3CR6Qu2iX2gsWXWYz1WX0rNE84
         POOAiWE04KEZPOt4zij3mkdE4H6TYXLfpMnyQVXjYsToaHFGhF8ghYRWHqInC3NNlqSN
         v4V2ejl5TsVcn8joCX6a/8ROcHgelI4EHVirNMJUsPsXWzkJ9BfplgtfeVNzUZBzSbCd
         VBo++RPt9aCk2CK1txaATPGT+lFX92NUw32RI1QtUBXWb4hbxkDGBrLW7x0LK+QdWrJO
         EL2A==
X-Gm-Message-State: AAQBX9f8OAgrH4cMMm+55FvrbVsVfpuUbZAR5/yYl1ysJ8XFZn/S/qN9
        cFtWjFFwHjK1loqZqUfNQBxmFWDMRHyVw9mXSxY=
X-Google-Smtp-Source: AKy350ZJFp4ygYt5vVOWkodzw/xs2MxAjKShCd6Z56Llw2RpJamb1SWiNIImBRaDaAaiQUHWqwZiLA==
X-Received: by 2002:a05:6512:39c4:b0:4dc:8049:6f36 with SMTP id k4-20020a05651239c400b004dc80496f36mr1980200lfu.1.1681083236366;
        Sun, 09 Apr 2023 16:33:56 -0700 (PDT)
Received: from lothlorien.lan (dzccz6yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::ab2])
        by smtp.gmail.com with ESMTPSA id d14-20020ac2544e000000b004e844eeb555sm1805321lfn.214.2023.04.09.16.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 16:33:55 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH] dma: gpi: remove spurious unlock in gpi_ch_init
Date:   Mon, 10 Apr 2023 02:33:55 +0300
Message-Id: <20230409233355.453741-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

gpi_ch_init() doesn't lock the ctrl_lock mutex, so there is no need to
unlock it too. Instead the mutex is handled by the funcion
gpi_alloc_chan_resources(), which properly locks and unlocks the mutex.

=====================================
WARNING: bad unlock balance detected!
6.3.0-rc5-00253-g99792582ded1-dirty #15 Not tainted
-------------------------------------
kworker/u16:0/9 is trying to release lock (&gpii->ctrl_lock) at:
[<ffffb99d04e1284c>] gpi_alloc_chan_resources+0x108/0x5bc
but there are no more locks to release!

other info that might help us debug this:
6 locks held by kworker/u16:0/9:
 #0: ffff575740010938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x220/0x594
 #1: ffff80000809bdd0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x220/0x594
 #2: ffff575740f2a0f8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x38/0x188
 #3: ffff57574b5570f8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x38/0x188
 #4: ffffb99d06a2f180 (of_dma_lock){+.+.}-{3:3}, at: of_dma_request_slave_channel+0x138/0x280
 #5: ffffb99d06a2ee20 (dma_list_mutex){+.+.}-{3:3}, at: dma_get_slave_channel+0x28/0x10c

stack backtrace:
CPU: 7 PID: 9 Comm: kworker/u16:0 Not tainted 6.3.0-rc5-00253-g99792582ded1-dirty #15
Hardware name: Google Pixel 3 (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 dump_backtrace+0xa0/0xfc
 show_stack+0x18/0x24
 dump_stack_lvl+0x60/0xac
 dump_stack+0x18/0x24
 print_unlock_imbalance_bug+0x130/0x148
 lock_release+0x270/0x300
 __mutex_unlock_slowpath+0x48/0x2cc
 mutex_unlock+0x20/0x2c
 gpi_alloc_chan_resources+0x108/0x5bc
 dma_chan_get+0x84/0x188
 dma_get_slave_channel+0x5c/0x10c
 gpi_of_dma_xlate+0x110/0x1a0
 of_dma_request_slave_channel+0x174/0x280
 dma_request_chan+0x3c/0x2d4
 geni_i2c_probe+0x544/0x63c
 platform_probe+0x68/0xc4
 really_probe+0x148/0x2ac
 __driver_probe_device+0x78/0xe0
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x84/0xe0
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 device_add+0x60c/0x7d8
 of_device_add+0x44/0x60
 of_platform_device_create_pdata+0x90/0x124
 of_platform_bus_create+0x15c/0x3c8
 of_platform_populate+0x58/0xf8
 devm_of_platform_populate+0x58/0xbc
 geni_se_probe+0xf0/0x164
 platform_probe+0x68/0xc4
 really_probe+0x148/0x2ac
 __driver_probe_device+0x78/0xe0
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x84/0xe0
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 deferred_probe_work_func+0x8c/0xc8
 process_one_work+0x2bc/0x594
 worker_thread+0x228/0x438
 kthread+0x108/0x10c
 ret_from_fork+0x10/0x20

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/dma/qcom/gpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 59a36cbf9b5f..932628b319c8 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1966,7 +1966,6 @@ static int gpi_ch_init(struct gchan *gchan)
 error_config_int:
 	gpi_free_ring(&gpii->ev_ring, gpii);
 exit_gpi_init:
-	mutex_unlock(&gpii->ctrl_lock);
 	return ret;
 }
 
-- 
2.39.2

