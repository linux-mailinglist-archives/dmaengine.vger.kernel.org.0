Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B87230C6D1
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 18:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhBBQ76 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 11:59:58 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53138 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237034AbhBBQ5v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 11:57:51 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8F508401F1;
        Tue,  2 Feb 2021 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612285010; bh=x6qwlQ3unob1xa78MC32IMOFOlfkiuMvvCbd1vCCzC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DOlHRSRbRskTtsKcMVpGRayc+AgUApQudbqdqM2Ms95sjOS1S3btwUIuzHUA625Dp
         Rtmo4GxRRrum4vj2Oe15EVJZym5AG9pkjQ5q0ISRVnRj/eeYO09EsfZRa7vobLKip+
         iK+fR9hanVOiVWPMeS0yDbH4vPQPXq/IVRbU5Pt1rQTwcslX5G+j4zpJiiRziOzV8S
         Rj0cEG/L0hY6jTpGNYddoiy/3EIYykXg+NVhMQo0bHFs2KtWo8yEnonSFHOK014T90
         H/OSnX6PYKR0gaahlVIBf5vgfGNuPaT0MvKGrQijd4WNr7zll6WVXY1ZL76tf5vL+S
         l397HPM90CGeA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5CBEDA005E;
        Tue,  2 Feb 2021 16:56:49 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [RESEND PATCH v3 5/5] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Tue,  2 Feb 2021 17:56:38 +0100
Message-Id: <4a0f089ec12d3f81c984cdc842160ba5b52064ec.1612284945.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Synopsys xData IP driver maintainer.

This driver aims to support Synopsys xData IP and is normally distributed
along with Synopsys PCIe EndPoint IP as a PCIe traffic generator (depends
of the use and licensing agreement).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66..f9d681b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5061,6 +5061,13 @@ S:	Maintained
 F:	drivers/dma/dw-edma/
 F:	include/linux/dma/edma.h
 
+DESIGNWARE XDATA IP DRIVER
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/misc-devices/dw-xdata-pcie.rst
+F:	drivers/misc/dw-xdata-pcie.c
+
 DESIGNWARE USB2 DRD IP DRIVER
 M:	Minas Harutyunyan <hminas@synopsys.com>
 L:	linux-usb@vger.kernel.org
-- 
2.7.4

