Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCA410BF3
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhISOoT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 10:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhISOoQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 10:44:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20418C061574;
        Sun, 19 Sep 2021 07:42:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j14so2231759plx.4;
        Sun, 19 Sep 2021 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDxzixVW4qLygzz/rLWj9i1sOmn4ydTQ+VNVepgXop4=;
        b=bFP3ASPSwK0f3oo6hhya5wy0m6LwqyFrTdEoE+EsuHd7Ssa/F5K5DNHSmHD9YQe5mD
         XJJt02G1rxeEZl9HSqLZI6uqYGw2C8RDvRMJm93Hj7yj3YHW5e53tdszA3WADPet9JwZ
         XKicVtb2RJWKSDyTNp+SYr1H3L6rop25kkV0I0W2nfHZdRNM24C29tkhRbWBG9LqYVPm
         Z/6jwNKMspDVFZAA8Q5MmgFLP0BzHwt8yQLYfRnTdzLVOAW1noApJoaW9nUbz3/GAbFt
         l2M9HRJKMU+MEmLDL0AtOMDmqWHHzbSFVoW4PH9QzydKD5KgeCO3Fex5tehLXa6qpuFU
         5xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDxzixVW4qLygzz/rLWj9i1sOmn4ydTQ+VNVepgXop4=;
        b=jR0sX1cwfq/U5Vy9bmmlkvWd3UZHHxlHr4mfU4yOrW+5DL2GrEQeLK+fNFBn8vW+gt
         vU8FYWZuJiMOwVgYJOqBfQqcg9M0PtG89Vyq1352Zjmf3nyrryGvJzzqGJCTbOAogVs2
         wv0YlwAsyH4p01+2nor5ljthIjfWM3AunFqbYOt/kFbSbKo30/zebDdSUDmmxyiIN51Q
         +imcNS75zxOMkK4pos2nVpSk0/kI5kHq/AoqBH95bL1jw9pQM6Sv7vqo0X1A8IcDncF5
         XjVAQC/lQqwrbNVmW+94d+300Mm95hWt6tF45QwT8BNCHLXpYupM/dHNv9Q6zSvTFevz
         a4UQ==
X-Gm-Message-State: AOAM5305tCQdAKQg1cp+1lSGba2lrbCJPAyN2+xiACWlXM2No+ul61qY
        1fuAXql2qNqHcR9/OgGP1w+e/o4BOYK9tw==
X-Google-Smtp-Source: ABdhPJw/0Jmwhw+JrJdfw+mjxFr4gQ17jjgvGrYZSoEfVMDWdke9OFspq+RwCbOefOkjbDAjcnLM1g==
X-Received: by 2002:a17:90a:e41:: with SMTP id p1mr24368045pja.137.1632062570352;
        Sun, 19 Sep 2021 07:42:50 -0700 (PDT)
Received: from skynet-linux.local ([106.201.127.154])
        by smtp.googlemail.com with ESMTPSA id v4sm11716151pff.11.2021.09.19.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 07:42:49 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH 0/1] Add support for metadata in bam_dma
Date:   Sun, 19 Sep 2021 20:12:40 +0530
Message-Id: <20210919144242.31776-1-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sireesh Kodali (1):
  dmaengine: qcom: bam_dma: Add support for metadata

 drivers/dma/qcom/bam_dma.c | 74 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

-- 
2.33.0

