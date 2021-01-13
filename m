Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC22F4A93
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbhAMLr6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 06:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhAMLr5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jan 2021 06:47:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11469C061795;
        Wed, 13 Jan 2021 03:47:17 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m25so2274492lfc.11;
        Wed, 13 Jan 2021 03:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOWDCh1gFoGjCDTknGsRVbOCLHvmp/ljiNTScRqytM8=;
        b=bXsv/KDma5fzkcKjeibP6rAesSCpsaFY0O0sHDjL8xHARpWNNi0sB4ZUcbq3QKHs2m
         YX0UhAZZx1FWsqhanGMTe0KuATSHEaZjPqP8mHSD+uQlth4x2TAzNE1m/fdD2N/1bAOD
         cy0/LLHREUuIAoWut6uEOUl06jpeQHvRipkop5Ff8crKjK9BCRi+NM+TByvkDYUDCbZF
         9NlKFFzY8AAHXH+Wsty0glTm5QTmHfMbzmNP2Tl4PGi8v/TLUdH35ON0OG3PieRFbQSM
         4wRCwUyzZbytiNmWcU+MCghO2W/+MNN0WQP+Ar3Mk6pHDlpPwRVBSlkZOqPtZJJ07Vy7
         mhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOWDCh1gFoGjCDTknGsRVbOCLHvmp/ljiNTScRqytM8=;
        b=oflDWUA+QaC/V2w5sfNHPw5Nw+0IzYIOc+DGKUzrHHhkMUW+IJEmAgRl5l9kfUTAMy
         38oa17WyEzLtOonk13MsWRvuys3568UzfYLcCLiR90AMh7qEkzLMqpT5io2rNrqlgj7n
         zp5Z+Cpz3I3HceLWmTxHQ/c6JxwghTNGWxmZ6ZUPB5XILsEksC9OTgRssre9zM8CTgrX
         7h65xxyTrvt7cf5ALedn3TEUJUiY/q85SmgjImVwEiQkt15fTUCWP+b0I2zmURcIt3oG
         cQsoljO1QdM6zUFg4nQYgzBbqJZKJd2CMDs/M7rdQBlFMLyf8YCeK37uAbXdMQ9W1tDZ
         Rvig==
X-Gm-Message-State: AOAM532yUYyAlQHWb6hUea8vzzOfCPA+BAbmVEv7fGf9GnOKx1rCNDGr
        I5FE4Jw+H6ccStk4xf4yh0E=
X-Google-Smtp-Source: ABdhPJwC8pjwfM8yH2xCMnXs3oCho97D4X+NuIY4CNGJ48fhoppBkEdCMWisSZ3Y+dvAU7AtfRbpgA==
X-Received: by 2002:a05:6512:21a5:: with SMTP id c5mr699803lft.423.1610538435636;
        Wed, 13 Jan 2021 03:47:15 -0800 (PST)
Received: from localhost.localdomain (91-157-87-152.elisa-laajakaista.fi. [91.157.87.152])
        by smtp.gmail.com with ESMTPSA id f19sm186489lfc.71.2021.01.13.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:47:15 -0800 (PST)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com, kishon@ti.com
Subject: [PATCH v2 1/3] dmaengine: Extend the dmaengine_alignment for 128 and 256 bytes
Date:   Wed, 13 Jan 2021 13:49:21 +0200
Message-Id: <20210113114923.9231-2-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
References: <20210113114923.9231-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Some DMA device can benefit with higher order of alignment than the maximum
of 64 bytes currently defined.

Define 128 and 256 bytes alignment for these devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/dmaengine.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 68130f5f599e..004736b6a9c8 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -745,6 +745,8 @@ enum dmaengine_alignment {
 	DMAENGINE_ALIGN_16_BYTES = 4,
 	DMAENGINE_ALIGN_32_BYTES = 5,
 	DMAENGINE_ALIGN_64_BYTES = 6,
+	DMAENGINE_ALIGN_128_BYTES = 7,
+	DMAENGINE_ALIGN_256_BYTES = 8,
 };
 
 /**
-- 
2.30.0

