Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118C860EF60
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 07:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiJ0FOx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 01:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiJ0FOr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 01:14:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C41CB0D;
        Wed, 26 Oct 2022 22:14:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5195986pji.1;
        Wed, 26 Oct 2022 22:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oMfxaXF7nRI4BLfRkUmZFlJUfBUODNFJS3becz/GPQ=;
        b=ZON6/JpoeO41g78FtnY6wu8/97zwQU3H41Ex8/Sk28ZEFSj0drFqzMy2meOlmlAW0c
         v6J496KoWJwEN6WYDR11wotmU6hAeTKOwwmhiOZRmi2lCEDMK9sz4O61D25ZrCraFCos
         cFPKTfs7tZUXqiJ9pJ4ddU4odhH921pkTe6TkbKjUCh8xQJpw2KQmSCaRXphz/bW04o/
         m1+/AbfSUPHxfYGLpgFbwUzrdZKrF8ygsbj1u2111qx7yyDjOFbm1Khf9/F1E41K8pZO
         uyxqVgD+1UGNwQfnMnDkIv4ysc4pkvqeyMIzGDXCkbvqmbF8wnwFuIPeksIG2/3nJtiu
         eRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oMfxaXF7nRI4BLfRkUmZFlJUfBUODNFJS3becz/GPQ=;
        b=TSrKn7RvkO6A6TLBNTGlies9E1fFk59jpVo668tuK+UK3gzIQPbuUUt/RKvN2LVW+K
         JJzHL0APbuEx05kHaiXVen4V1q5xjoIkkQVDd2TIFGVhKDSp0x8X3owKObeE/S9IS6/S
         Aw+hNj//K+YXUDnEo67qmvBG8cI84HQctyR26SysFcpzvEAwZ0Vfyu1ILbx+G+PeAQgg
         F79nYnRzn/30eWieHgL1MAq4Lu1K98w/57S79mRmL41Yi6cqbXIGInhWbXGycsBsjQfG
         mljVcoLSva4zWG0zyosw7dguIo9hUKGJN0iLtm7iIih13CqD9SZvYH1N7DhFe2UN0Bwx
         Smag==
X-Gm-Message-State: ACrzQf27C95fbyqxJXXHMQ2l47tVjIppKq7kec4wRhAlfH3gZeiMomFd
        g+Zhh+Ns5l9WogE3d7ffRIo=
X-Google-Smtp-Source: AMsMyM6LdVb3pwNKgm9TQaOrdm/oRLxBIWu8X88HIbZcvT49c3mpI/PeeYndAhpIxWAAZWIHmvczVA==
X-Received: by 2002:a17:902:d4c4:b0:186:a951:b8f9 with SMTP id o4-20020a170902d4c400b00186a951b8f9mr19152254plg.130.1666847683310;
        Wed, 26 Oct 2022 22:14:43 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:dcaa:bb0:9908:b137:b0b4])
        by smtp.googlemail.com with ESMTPSA id s8-20020a170902ea0800b001869ba04c83sm216713plg.245.2022.10.26.22.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 22:14:42 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     dmaengine@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 1/3] doc: dmaengine: client-api: Add immediate commands in the DMA client API
Date:   Thu, 27 Oct 2022 10:44:27 +0530
Message-Id: <20221027051429.46593-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027051429.46593-1-sireeshkodali1@gmail.com>
References: <20221027051429.46593-1-sireeshkodali1@gmail.com>
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

Immediate commands are used by the IPA driver to send commands to the
microcontroller over BAM. These are different from PREP_CMD.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 Documentation/driver-api/dmaengine/provider.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index ceac2a300e32..5afe21191299 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -590,6 +590,16 @@ DMA_CTRL_REUSE
     writes for which the descriptor should be in different format from
     normal data descriptors.
 
+- DMA_PREP_IMM_CMD
+
+  - If set, the client driver tells DMA controller that passed data in DMA
+    API is immediate command data.
+
+  - Interpretation of command data is DMA controller specific. It can be
+    used for issuing immediate commands to other peripherals/register
+    reads/register writes for which the descriptor should be in a
+    different format from normal data descriptors.
+
 - DMA_PREP_REPEAT
 
   - If set, the transfer will be automatically repeated when it ends until a
-- 
2.38.1

