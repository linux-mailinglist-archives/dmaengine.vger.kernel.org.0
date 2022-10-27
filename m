Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236AC60EF5A
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 07:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiJ0FOt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 01:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiJ0FOn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 01:14:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57591FFBA;
        Wed, 26 Oct 2022 22:14:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 20so230873pgc.5;
        Wed, 26 Oct 2022 22:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4hWelOnEbrc806II5CSVNst+RddSBPiYPEc0MyWLg8=;
        b=H6JHrKuudZywEKrPvD5NLwVW9QmPV1n8Pxjx9VN1VMWnktDUIVh2qXh4oeXyb8OwMw
         JaMBwe9dZ7nFSA+Sj8mmfqk1d79WhWTb5bG5n0+3GetZA0BMpfIy4pzwgIvkieilOyrR
         2/5/0fmN6HxWWTmEujrvQxP/ao1OpfpJfnjusYnDqcUd2ekO5Z0Mn1YhMIYdz3wKz9il
         HQPbOnQ6ysvcLuTEN1bfb2YDBM4cmnR4w7f09mcrcsd4i3cnGQpoYgEuu375vFH1RVv2
         cjuX07SEOVgSuB2hL1TFNhzeJhGfFgp02ODLpxTQ/smWw1Ii04tbE+MTGFadZxEzyX6F
         U82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4hWelOnEbrc806II5CSVNst+RddSBPiYPEc0MyWLg8=;
        b=GVIUIv0jY3H7wd2utxKub1I6aBdCDwRc5pJA9pgAd8SNXsAlxIcAEKYkhWK6fbGoJ3
         OYF6+LwkcJ+EUPEn4uC9UO7DxeSlB72iSuwRbrMgihD7ETqNWKgbGUU/EAyt5eIZsrGa
         dCVdEcAqrk42LH1hXMSVRJ6mIsMcef8mCELPHmPGcAzvFDjprhT1ql6klSo/uLC1ZYHl
         qj1yJam6UkBnWaUqETqhK5LasyjaiUUfcZymSKRvVnWOQ8ODmWAtgSS1bGqNlz9kBPOQ
         PjVx3iDz+mNNKX4nFlIOOIA6gBe0a+xvE1WV9KcHNjNIFhZPV9EHTnhZveckj9/SSxyM
         ZpyQ==
X-Gm-Message-State: ACrzQf1/4AzXP8TqGIcbYHPIAaBLsTnESbX1LTd3CwbK5jas9Dh0tlom
        3NJW042qwVgU5y9GLOgROBpaag0EZ1g=
X-Google-Smtp-Source: AMsMyM6HhibPZ9YFsU62O2xgFBGHdWB0hrmAp2XJgMd98ZUGlwI8IfEHkAq+Gqt4SCjlHeMFRe/GZQ==
X-Received: by 2002:a63:914b:0:b0:46e:dbd5:ae15 with SMTP id l72-20020a63914b000000b0046edbd5ae15mr22865435pge.94.1666847679807;
        Wed, 26 Oct 2022 22:14:39 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:dcaa:bb0:9908:b137:b0b4])
        by smtp.googlemail.com with ESMTPSA id s8-20020a170902ea0800b001869ba04c83sm216713plg.245.2022.10.26.22.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 22:14:38 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     dmaengine@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v2 0/3] dmaengine: Add support for immediate commands
Date:   Thu, 27 Oct 2022 10:44:26 +0530
Message-Id: <20221027051429.46593-1-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The IPA v2.x block, found on some older Qualcomm SoCs, uses BAM DMA to
send and receive packets from the AP. It also uses BAM to receive
commands from the AP (and possibly the modem). These commands are
encoded as "Immediate Commands". They vary from regular BAM DMA
commands. Adding support for immediate commands is trivial, but requires
also adding Immediate Commands to the dmaengine API, which is what this
patch series does.

Sireesh Kodali (3):
  doc: dmaengine: client-api: Add immediate commands in the DMA client
    API
  dmaengine: Add support for immediate commands in the client API
  dmaengine: bam_dma: Add support for immediate commands

 Documentation/driver-api/dmaengine/provider.rst | 10 ++++++++++
 drivers/dma/qcom/bam_dma.c                      |  3 +++
 include/linux/dmaengine.h                       |  4 ++++
 3 files changed, 17 insertions(+)

-- 
2.38.1

