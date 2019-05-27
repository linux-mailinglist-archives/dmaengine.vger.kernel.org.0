Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE082BB40
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfE0UPT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 16:15:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42450 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfE0UPP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 May 2019 16:15:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so17878402wrb.9;
        Mon, 27 May 2019 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kX1q8iX0X4303ErWm6lM+rRst5YhXcgIu4cEhOJHl1c=;
        b=FxY8LQQd0PZVApVNIF+eHR5wYvbPUxCZAA5A1YZjzxZ7eM+eWerTJam3mrqVRMSYEe
         kjQ95H/YeXQ5HdiiMDBshV81jYgwBpgEeL91TdAz4p581fj0KHLbyS8rsxUOT7otLd30
         e6smxAcZcGyyn7sz48eglWl86Bi/FVXnKEVshr8jJmsrq9IjhRrH72GEjl3QVGs9CWJx
         ZmjZ0AHJtrC4BLATXmkTn9OSa1I5Tmu1asg90LTaKMM9XR4Jf1ICtMFyaxDhaNYj4asi
         XWq3Z3bmBcUaryPHRrI7hrdP+mlKPzlZ1YG+/95rZnfrgMQzQjgik4vvFEDar/OPe0Z2
         HO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kX1q8iX0X4303ErWm6lM+rRst5YhXcgIu4cEhOJHl1c=;
        b=s+F6/2aQfQw1IyM1Tpu2EMQU8v+kp6THj9ok5f3TObH9L5f/lLYimA0roHtgb5x6PB
         p07JHGuMt5t85rpb6VQNy+BVOurSKPvXFn35AesVMuZuI01uVzxIDMjt3TNBzE6HogYO
         hho6eCHZOSpG5Bk5eowZp3lsNKJg3Wgd5EO7xwm65MA830OEM4nn9SFplZ8CF4N5TxVa
         TGntD7m3CIogYVr2zniteJ1h550xWoKxPspmfk57uhp8M4PKFeEE3eYMVb4V23WjbM97
         MZiyMVUFXsw89ABwQoYCJpfyRGZQNOx0u/WV1bTW+/JCuNoPiJOMLSbMITFeEBd4xMCC
         21Cw==
X-Gm-Message-State: APjAAAXbbB3tslpEdPfAZjL8pw393XqayeA3nemIKGXF/+VzigpLYGoj
        sQHLTep1nczPQOxaVSHwdrY=
X-Google-Smtp-Source: APXvYqw43Ws45Qhr7xAS6WK8q2QHHFf0KA8NC8Pf9gwKYfj+j7tHTjZkvjaposYHAiD6VDUxbsNV/w==
X-Received: by 2002:adf:f2c2:: with SMTP id d2mr1885143wrp.153.1558988113583;
        Mon, 27 May 2019 13:15:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id i27sm347146wmb.16.2019.05.27.13.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:15:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 7/7] arm64: defconfig: enable Allwinner DMA drivers
Date:   Mon, 27 May 2019 22:14:59 +0200
Message-Id: <20190527201459.20130-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527201459.20130-1-peron.clem@gmail.com>
References: <20190527201459.20130-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allwinner sun6i DMA drivers is used on A64 and H6 boards.

Enable it as a module.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..b535f0f412cc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -614,6 +614,7 @@ CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=m
+CONFIG_DMA_SUN6I=m
 CONFIG_K3_DMA=y
 CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
-- 
2.20.1

