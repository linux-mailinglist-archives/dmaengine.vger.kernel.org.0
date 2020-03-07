Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5417D01A
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2020 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCGU5u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Mar 2020 15:57:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43827 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGU5u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Mar 2020 15:57:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so7087412edb.10;
        Sat, 07 Mar 2020 12:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LtsEha/XMPd3H7XbaZdQYCuIT3uvzKy6NtPyu/HzRNM=;
        b=hvhkaQ8m+8C9w1zT3C0+qJ790PBudbc5zOet6egLZ8Yyl/RT8shv2AK1pEGIZeuOBV
         srtS9HPtlfji69lsJU+8WipYOGync1i8XhCPqeFZ0lZ6I8mocKSO3fGsOz7WW/XeFAT9
         SkGczQwGkD/vsVfW82OmzkBrC0kLK/0GqEQVQC8gZoGYQ0WWfLpmK9hzbWnNxvttFi9E
         PiNelIET+Cg13YZLIgBrQ8EWolS8zytEY8EuZpO/So/TG+LOh+cf47RSyi2bgicKI0SY
         lMpWXJn01MICH1veIjClTlNWv31qEqbWPK3XkdmxW/tIJtWsaui+xxKnT4XBFsAPBUTr
         2niA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LtsEha/XMPd3H7XbaZdQYCuIT3uvzKy6NtPyu/HzRNM=;
        b=uBC8susR/OqYmF5pVyXMjXVm3pe/y/hvgpjP4TB622gtJR1ROri0CQslINCqnxOX9n
         cepGCY5mOhhhZ/wuko0vHkKOD7dPqC+Bw7dmEByFn1DSReZYkVkzqYbs7i3Y4mr4quhe
         KhDZ9JBMFcDEcNLNGMxSYm4m/SW238znVyVyhxR+Rq/IWyQZkNvB0zdjRQ8iE6s8wg6i
         nl7+Sq+1MAhNmaWBoVFJVK3w2fT/E9HFJl1Vg6EYmcmAUsNQJzISTHlC5XRHEv3eF5OO
         Wi+nDa3cAneYM1GaLNrt/Zhbwd+gyljJ0C2mvZJwZIb8wPBDTnAVk73hF8WNoPEgIIuo
         F1hQ==
X-Gm-Message-State: ANhLgQ3Mvu+6F2PRRY6anqe+RXT/y3RDOP3O1IycmHLH04Mm0vYhTj2W
        62YZrN6K2L7mcYTaur9Yqzo=
X-Google-Smtp-Source: ADFU+vttpXgHC3Io2gYpesXxMaP8TvXRjo8DxuX7Xi15swI6F5QAv7riGHHpPEnHAjHi1tBUXNZCTQ==
X-Received: by 2002:aa7:d510:: with SMTP id y16mr9945582edq.214.1583614668444;
        Sat, 07 Mar 2020 12:57:48 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dee:1100:9dd1:961d:b5c1:34aa])
        by smtp.gmail.com with ESMTPSA id z19sm1177268eja.53.2020.03.07.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 12:57:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify the INTEL IADX DRIVER entry
Date:   Sat,  7 Mar 2020 21:57:37 +0100
Message-Id: <20200307205737.5829-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data
accelerators") added the INTEL IADX DRIVER entry in MAINTAINERS, which
mentions include/linux/idxd.h as file entry. However, this header file was
not added in this commit, nor in any later one.

Hence, since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: include/linux/idxd.h

Drop the file entry to the non-existing file in INTEL IADX DRIVER now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20200306

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c93e4937164c..303e1ea83484 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8478,7 +8478,6 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/idxd/*
 F:	include/uapi/linux/idxd.h
-F:	include/linux/idxd.h
 
 INTEL IDLE DRIVER
 M:	Jacob Pan <jacob.jun.pan@linux.intel.com>
-- 
2.17.1

