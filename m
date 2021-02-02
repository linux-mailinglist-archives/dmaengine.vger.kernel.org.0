Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9530C6E9
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 18:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhBBRE1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 12:04:27 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53092 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236984AbhBBQ5v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 11:57:51 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 767654017D;
        Tue,  2 Feb 2021 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612285007; bh=+auZmpcKoLtjzoJGo6Msp1yOj0Ox3iggz0BY5h+429o=;
        h=From:To:Cc:Subject:Date:From;
        b=j2WhAPuU8d8+zdfAE9/5G2SGrCQQFWXX9L7vPxQo5yvUQUdbIlcD99tH+Ebai3dOc
         6ZxCQ33Woc85T9pM26Lag5A+B3ZzkOZ4PLV022psLNMXQFnIguYrbI+l44jhoC4Wuf
         xuaOdKa3dXEZl24qSGusXrB5I4e7H0j81uKtaTJ5Su/0r02+bC3ykzAcPFNwler7p3
         Bt70Z9qoNGhQTax8yV/hOQOFlPD62YB1w0eeCREGjHs3Xves/AM/8ZridsBqgAaKCB
         2SJKGY8FPJcyu5lJQtnb32jVfyIOPCOem6/rSoeTmSYP69aNaNaF1Z5bmBWzLRISUq
         uwpodwkUIn+Uw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 69380A005E;
        Tue,  2 Feb 2021 16:56:43 +0000 (UTC)
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
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-doc@vger.kernel.org
Subject: [RESEND PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Date:   Tue,  2 Feb 2021 17:56:33 +0100
Message-Id: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
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
 V2: Rework driver according to Greg Kroah-Hartman feedback
 V3: Fixed issues detected while running on 64 bits platforms
     Rebased patches on top of v5.11-rc1 version

Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-pci@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Gustavo Pimentel (5):
  misc: Add Synopsys DesignWare xData IP driver
  misc: Add Synopsys DesignWare xData IP driver to Makefile
  misc: Add Synopsys DesignWare xData IP driver to Kconfig
  Documentation: misc-devices: Add Documentation for dw-xdata-pcie
    driver
  MAINTAINERS: Add Synopsys xData IP driver maintainer

 Documentation/misc-devices/dw-xdata-pcie.rst |  40 +++
 MAINTAINERS                                  |   7 +
 drivers/misc/Kconfig                         |  11 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/dw-xdata-pcie.c                 | 379 +++++++++++++++++++++++++++
 5 files changed, 438 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
 create mode 100644 drivers/misc/dw-xdata-pcie.c

-- 
2.7.4

