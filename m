Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8745734BFF8
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhC1X4n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhC1X4i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:38 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C0C061756;
        Sun, 28 Mar 2021 16:56:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q3so10893459qkq.12;
        Sun, 28 Mar 2021 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2CB+oDzRlKTXsQgvZVkoJMCXZMGg7B/MCg4u+Njtv4=;
        b=DU3fOkSXckynV4e9icZMhz7PfRsCbCFt8b1N3nx+vNJ0YQAtxeW+KmaA1o2ylavs+P
         G9TimVl49iLForzkyymJxqn2b28D4EzXm+ZI4/+f1dCXrwhbTbfRDX5G0QL1ER3Fhh0x
         dpDIUd6cWj4XZo/T3/DIaUMXfwdvNDgHGrHnl2tCzUbRq0Jfg/A1B6xXt+lUOwYkWcpB
         T868H80uh8Oet/UF1dj/OlPzy7hR3Ne9fF8ulO7aD4HXzCovy4cvZLjyK5mn8psXkAyf
         Suwp4AtV5/4hhTchePwPzbFsv8AI9iWSj9p3cyHx4hXz3hJw06YVnKG5SESwuZzZ6r74
         UuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2CB+oDzRlKTXsQgvZVkoJMCXZMGg7B/MCg4u+Njtv4=;
        b=FcYVujGkkzqsjmdgBBa9eGZKTIGZ8FsMQMewZ2TpMB2PMI3YfyVjvnJODafg/QZ4tU
         Q3OD/j4EUkYugS5wYSDSG/OJq8CFciKrkGUcU3NHZBMeufnmdfvltBiJHORTF2fyVkgr
         25gwtCD0iGozHr9fCVQbbGrXK7cl6BZT4BklCYIYsi5fR1CNM0cXnOYPFSsMtjSF2Bzr
         h92L//vM05sIUOaPpjYa5KYojVSraSWINfvEflumb+SVVZfhJV1OjTs0N1/qUTY4KAJU
         f5OhjGJ+LTkvhbgTQeyOh35Bdh4rbA69t1zlgf+N50V3TmPwj0SiUl3xsrv8dP35pJNm
         dNkA==
X-Gm-Message-State: AOAM533LaM2/H4puWFcj2zsXR0hA5vX7aFxN9lejfzODUKgz+U6vnpyU
        nlpQr4DrPO/UO/bDCFTgpOcEnTZVNiKA6FW1
X-Google-Smtp-Source: ABdhPJxvo48SXWkMjNKknPMovLJbk743rE6Sor3y7HvVUau8ciblHI5RRV983LICXWJpgrB6vyRknw==
X-Received: by 2002:a37:9f4e:: with SMTP id i75mr23450908qke.283.1616975797420;
        Sun, 28 Mar 2021 16:56:37 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:36 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/30] mv_xor.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:04 +0530
Message-Id: <46df86afac6c221e7eda9586db1233750c1c5477.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/capabilites/capabilities/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/mv_xor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23b232b57518..a43388b6a30d 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1074,7 +1074,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	if (!mv_chan->dma_desc_pool_virt)
 		return ERR_PTR(-ENOMEM);

-	/* discover transaction capabilites from the platform data */
+	/* discover transaction capabilities from the platform data */
 	dma_dev->cap_mask = cap_mask;

 	INIT_LIST_HEAD(&dma_dev->channels);
--
2.26.3

