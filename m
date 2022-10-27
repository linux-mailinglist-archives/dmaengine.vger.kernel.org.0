Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8C60EF70
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 07:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiJ0FUr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 01:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ0FUq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 01:20:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D48B153E09;
        Wed, 26 Oct 2022 22:20:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso5217641pjn.0;
        Wed, 26 Oct 2022 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c98TshV0sVbCsSk7aMfhfHp9AIQDXwn0PvylKZ9s3/c=;
        b=bOHlO7ccEdD1rw/fpFt4CQzLk9chgVa2o8KJxfjzlV84rMKV+UAkhGikJn81vw6EHz
         SwHrBxx829mv7VhR7RTk4hrnpWPOgZg6aUhqfMieN1vypMsUj2n1e4F8MgEamCPOBLfg
         FBLt9LG1GBNKrzEoqKm1oi03h8B0YQ20xHliOeAW8YihZ5yjL3BLdNcMcXB7CttvGrk/
         fV52Taio4mWmy9GQUjV7N/hmav2ThghZU8Wf2fvx8nK3+yxXQ+DkcSZ6L3pWSLQF4EBt
         90rjlCnnAeWK+7pci2iC8y6eYbQbdhuRnchVJIRNapSxIdSnQaoIVsRQ3LHRaxfPKSnV
         edww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c98TshV0sVbCsSk7aMfhfHp9AIQDXwn0PvylKZ9s3/c=;
        b=v5wZkJUp6NZ+ke5Ml4aYOFyJtajBlNojAVg+4B10hhrsR9BhBM+fDRexVPkQL12q+h
         zgnAHpx0NEcfnRJ4tU3WCl0JNAvaXHAnD92KDZ6lSlE+2fMvXpTuk1TeLynlw1uoyG14
         PDfuChzIfRFKk41ZWqY7VcbbIfm647vIsjUIAgBbw3Xw9Uo1iEWixdjIJ++ozuULmqY1
         cwVuVZBqqnbAa/gEn0+JAwfcqkx1HHR4P5f6XGmnySUhTHB3oC6aeuJkp3/8xP/DZwW6
         z4RQA7M2mRPtNunb+vZ4zVbWk9TK0AcSgtoqPRYPTOoBgn8GT4j3GECzqJEu8V7AWVMa
         cnxA==
X-Gm-Message-State: ACrzQf3z4O8yKGvv1dpdIOZ3Sl4nNYnnO0jKcjWSgrsh1Z3k+UXNWtYd
        riaXisM8v5af7cLpfAG4gH0=
X-Google-Smtp-Source: AMsMyM4OD3oGiBqCNRkzsMEg9amdbhFFfPUzyaBgkF6OktEK/J2FZe6rM2I9RLwKeorMwr+H5K2adQ==
X-Received: by 2002:a17:903:32c2:b0:182:1a9c:8f40 with SMTP id i2-20020a17090332c200b001821a9c8f40mr48878611plr.54.1666848045618;
        Wed, 26 Oct 2022 22:20:45 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:dcaa:bb0:9908:b137:b0b4])
        by smtp.googlemail.com with ESMTPSA id u9-20020a17090341c900b00186afd756edsm218874ple.283.2022.10.26.22.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 22:20:45 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     andersson@kernel.org, agross@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     dmaengine@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v2 0/1] dmaengine: qcom: Add support for metadata in bam_dma
Date:   Thu, 27 Oct 2022 10:50:06 +0530
Message-Id: <20221027052007.47403-1-sireeshkodali1@gmail.com>
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

IPA v2.x uses BAM to send and receive IP packets, to and from the AP.
However, unlike its predecessor BAM-DMUX, it doesn't send information
about the packet length. To find the length of the packet, one must
instead read the bam_desc metadata. This patch adds support for sending
the size metadata over the dmaengine metadata api. Currently only the
dma size is stored in the metadata. Only client-side metadata is
supported for now, because host-side metadata doesn't make sense for
IPA, where more than one DMA descriptors could be waiting to be acked
and processed.

Changes since v1:
 * Rebased onto 6.0 kernel
 * Patch redone by Vladimir

Vladimir Lypak (1):
  dmaengine: qcom: bam_dma: Add support for metadata

 drivers/dma/qcom/bam_dma.c       | 57 ++++++++++++++++++++++++++++++++
 include/linux/dma/qcom_bam_dma.h |  8 +++++
 2 files changed, 65 insertions(+)

-- 
2.38.1

