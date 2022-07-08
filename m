Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980E956BF7F
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbiGHRB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiGHRB7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 13:01:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7021F618
        for <dmaengine@vger.kernel.org>; Fri,  8 Jul 2022 10:01:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a5so16665448wrx.12
        for <dmaengine@vger.kernel.org>; Fri, 08 Jul 2022 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2Td8oL+DP/Q1s4zsf07k4XdXJJCRjGdcs4j+JMi+M0=;
        b=E4fegH8AA6z2N2S142RPFIDcT4aTf/9A25WCIatRlLcZioJSoRoOlQTCR9qI+Vk62g
         08VAESHPLztMQcIk9J61xc5w52quQfl6oDXtVeuX6rI+VHEuGXB1SzW4bSJRbRwYL7uQ
         UxonLNF7qKW9X0Trlngp7sexV5ZNCeSTVVR2EbdK+kDDW+xu+jYI0+ZIMr6GgnFt3+II
         G2+HVNa4CveJpuCZ8b777PuLjubxIwTcmqNNpBgKqdU+9qQ5/e2I+UUI4NI4JHV/2Cp0
         ArgmbAk6vc+h20kp9yc6wcASYMiF6QU7LbhFt63vIVRI9oo/1P8Y4HWDj/aZqMeXq5+v
         oUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2Td8oL+DP/Q1s4zsf07k4XdXJJCRjGdcs4j+JMi+M0=;
        b=fkCcAczBI2k72NKrLVj1T2eCqW80wUgR+LM6aLP1A5u+ZC2XOQlA6kwy8chIHWGcZs
         MNiDGyD6MIA6/05xfQ0Y+NZ/fieCm5MJJpOrdJJSZWPIr/yREJyJY5i69T+u+po6EWCg
         VzDTo/iUj9feLHb3wa7DOrx3ineHh2uv+ueE9lGVZ/dOT0sWWETHRqYFEpyQGvgW2YCF
         7wVrMlJyM1f6vd/QV+j/MvmulRMuKVF8M8GtSxk2jbemsxM0eQLZi8AxnoLS2lfSz2qN
         MiX6G3LnW3hCigUHiSYSw4jBCCd4pzNw5uiRwbGllUldfLOuHt5w8F4neO/+9Lgsc/0s
         1o8w==
X-Gm-Message-State: AJIora8Bu9nCVdFMKvBvZumZZZ5WZ1qSfMnM494TOwg3QqIDsbM0GcsL
        JkcOC5qhpZ0O5rPH5ztAbrI/vC5n44Kaqq3G
X-Google-Smtp-Source: AGRyM1u7by1zvcxm/P8FP14CKaCIB4lENgo23/wSKJKIonXN7rCuigAijPwL78UQKKChlPANOgLSAQ==
X-Received: by 2002:a5d:6d06:0:b0:21b:c434:d99e with SMTP id e6-20020a5d6d06000000b0021bc434d99emr4056270wrq.148.1657299716615;
        Fri, 08 Jul 2022 10:01:56 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t5-20020adfe105000000b002103bd9c5acsm41336252wrz.105.2022.07.08.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:01:56 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 2/3] dmaengine: dw-axi-dmac: do not print NULL LLI during error
Date:   Fri,  8 Jul 2022 18:01:52 +0100
Message-Id: <20220708170153.269991-3-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708170153.269991-1-ben.dooks@sifive.com>
References: <20220708170153.269991-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

During debugging we have seen an issue where axi_chan_dump_lli()
is passed a NULL LLI pointer which ends up causing an OOPS due
to trying to get fields from it. Simply print NULL LLI and exit
to avoid this.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 75c537153e92..d6ef5f49f281 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1008,6 +1008,11 @@ static void axi_chan_dump_regs(struct axi_dma_chan *chan)
 static void axi_chan_dump_lli(struct axi_dma_chan *chan,
 			      struct axi_dma_hw_desc *desc)
 {
+	if (!desc->lli) {
+		dev_err(dchan2dev(&chan->vc.chan), "NULL LLI\n");
+		return;
+	}
+
 	dev_err(dchan2dev(&chan->vc.chan),
 		"SAR: 0x%llx DAR: 0x%llx LLP: 0x%llx BTS 0x%x CTL: 0x%x:%08x",
 		le64_to_cpu(desc->lli->sar),
-- 
2.35.1

