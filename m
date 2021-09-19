Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8825410BE0
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhISOet (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 10:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhISOet (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 10:34:49 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1FC061574;
        Sun, 19 Sep 2021 07:33:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so14759849pgr.11;
        Sun, 19 Sep 2021 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDxzixVW4qLygzz/rLWj9i1sOmn4ydTQ+VNVepgXop4=;
        b=bQXsrcOSH4L3JxdQRZRCUYUU4dxddjNDV2CKo1g88ucDU2jw4z5k24S1G3roj70hxI
         XoAPo11ZZdYCz8yOwiFkv4BDAoCtErTCf7IGVyR1c4obYEpe61d+pyNRTjoJXvqbgFaR
         HfziQO2K7pQS/eOvh5pbowqVnxfJVD7gshi0Nf9c5nwE7gx0KkwQRD/r5Qm6/GoY3QPG
         g6S3/atA31w0BwKjZczj3XsCZNoFvaD4r5ytdd3Uxk5qG30oOeW8ZoDDdurn6I+fBLSp
         EzY96o2wYnYSRTPqHWJ8Kr4ORzY7T6cQUrkIEQ9vVddFUR++u7SHDrKN1GPx4Zv+L8Uv
         kcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BDxzixVW4qLygzz/rLWj9i1sOmn4ydTQ+VNVepgXop4=;
        b=4pBkQ05+7YOGtglYqPdctayiICkcz/j/3A6fIhjQLXEoUhtkpLM5XOz8ERL/v6jzaR
         m1xNgcjsfBI/UagZtis39NWlpxeCLjdij2ge8BcXl2nO0PQ4wBdyfLl6VkwUmuHGQKvG
         tARF3BxT6R2J1P0TBCGkJRTw5eUL6UzL1/K3TH+7mzZg3l/s/vcaTy/32qbCZwJP1fVP
         ohAXlDDvjvmFAoAElZWOhrJqnqvDhU1rMwRsY2LIWoZWhSHLGNmJ8bx6Nl0+f86ONCHX
         /9slYkxfzjGWzJ2TGxqJhyKZ+0pMQ+AHLzDMX8g1IOJ0okwsLkUk4faD5uRsU+kloc0C
         qOxw==
X-Gm-Message-State: AOAM530tnI5Rew+UZTiXuR0svfaCNbnwps4fk1Vy531zGk4Ziv+6TRo5
        Xj4BiJ4nOY9kE9lAdzFA7cSyEqUnpZG0bg==
X-Google-Smtp-Source: ABdhPJwUIh6IB3dx/EHH8UIYeMxZ/aDKDyVul/PTJJsUNhJZxC+tGt+oEU38ATN29dWoZjnFc40sdw==
X-Received: by 2002:a62:8015:0:b0:43b:400c:7a73 with SMTP id j21-20020a628015000000b0043b400c7a73mr21045432pfd.34.1632062002769;
        Sun, 19 Sep 2021 07:33:22 -0700 (PDT)
Received: from skynet-linux.local ([106.201.127.154])
        by smtp.googlemail.com with ESMTPSA id m2sm13062149pgd.70.2021.09.19.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 07:33:22 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH 0/1] Add support for metadata in bam_dma
Date:   Sun, 19 Sep 2021 20:03:10 +0530
Message-Id: <20210919143311.31015-1-sireeshkodali1@gmail.com>
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

