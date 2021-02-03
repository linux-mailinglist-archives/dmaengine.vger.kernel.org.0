Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1E30E59E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhBCWEv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 17:04:51 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52526 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232977AbhBCWEm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 17:04:42 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BCC16C0092;
        Wed,  3 Feb 2021 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389821; bh=2pKLdod2GO+jRlwFYu9PV3d8HRi2LQseZD/x2A6Ojho=;
        h=From:To:Cc:Subject:Date:From;
        b=bFphL6eCHyZDCYW3UvGK3FfVefQRfCOVh36xr7YFTkwfZv3maxgrdLk+AasPTgfoN
         MKxsBvWQfWtxD0DU1YEJFqXOb4Q0e1Wne05TKDztOZV6RNAyuvFJt99CG+dziPzbA9
         diu7iEPS88o59jA2f19tsKTPUtk4njFDelvn9KPPBVczOAK4fwoQLafSjiIWE+iy4y
         KrXtihMHC7q275WOQijMNgKGLXyWwldkjEE+o8pRyO2J8UWuZLVnkm1i7wldYZYFVP
         ifmuFvvCxS1E9vqNRXIXildHx9LZMaMvVOV6n9hNJFpGSoyD5GkTJZNKSd/zfLOgXO
         tUjpv59tCn/Xw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id C112BA0249;
        Wed,  3 Feb 2021 22:03:37 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v4 0/6] misc: Add Add Synopsys DesignWare xData IP driver
Date:   Wed,  3 Feb 2021 23:03:24 +0100
Message-Id: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series adds a new driver called xData-pcie for the Synopsys
DesignWare PCIe prototype.

The driver configures and enables the Synopsys DesignWare PCIe traffic
generator IP inside of prototype Endpoint which will generate upstream
and downstream PCIe traffic. This allows to quickly test the PCIe link
throughput speed and check is the prototype solution has some limitation
or not.

Changes:
 V2: Rework driver according to Greg Kroah-Hartman' feedback
 V3: Fixed issues detected while running on 64 bits platforms
     Rebased patches on top of v5.11-rc1 version
 V4: Rework driver according to Greg Kroah-Hartman' feedback
     Add the ABI doc related to the sysfs implemented on this driver

Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-pci@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Gustavo Pimentel (6):
  misc: Add Synopsys DesignWare xData IP driver
  misc: Add Synopsys DesignWare xData IP driver to Makefile
  misc: Add Synopsys DesignWare xData IP driver to Kconfig
  Documentation: misc-devices: Add Documentation for dw-xdata-pcie
    driver
  MAINTAINERS: Add Synopsys xData IP driver maintainer
  docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver

 Documentation/ABI/testing/sysfs-driver-xdata |  46 ++++
 Documentation/misc-devices/dw-xdata-pcie.rst |  40 +++
 MAINTAINERS                                  |   7 +
 drivers/misc/Kconfig                         |  11 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/dw-xdata-pcie.c                 | 378 +++++++++++++++++++++++++++
 6 files changed, 483 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/misc/dw-xdata-pcie.c

-- 
2.7.4

