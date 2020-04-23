Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9261B5CA8
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 15:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgDWNfa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 09:35:30 -0400
Received: from mx06lb.world4you.com ([81.19.149.116]:38508 "EHLO
        mx06lb.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgDWNfa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Apr 2020 09:35:30 -0400
X-Greylist: delayed 1578 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 09:35:30 EDT
Received: from [81.19.149.44] (helo=webmail.world4you.com)
        by mx06lb.world4you.com with esmtpa (Exim 4.92.3)
        (envelope-from <eas@sw-optimization.com>)
        id 1jRbbL-0007oF-0A; Thu, 23 Apr 2020 15:09:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Apr 2020 15:09:10 +0200
From:   Eric Schwarz <eas@sw-optimization.com>
To:     dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Use DMA Test Kernel Module for FPGA Device
Message-ID: <3955779b6d28751c45ab5af01095ef88@sw-optimization.com>
X-Sender: eas@sw-optimization.com
User-Agent: World4You Webmail
X-SA-Do-Not-Run: Yes
X-AV-Do-Run: Yes
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

I think it is not possible to use the dmatest [1] kernel framework for 
testing a DMA engine located in an FPGA where the FPGA is connected to 
the host system over PCIe.
However, does any one have out-of-tree patches in order to do so for 
dmatest or knows a project which could be used for that case?

System setup:

                                          +-------+
                                          |  DDR  |
                                          +-------+
                                              |
                                              |
+--------------+                   +-------------------+
|              |                   | +------------+    |
|              |                   | | DMA Engine |    |
|              |      PCIe         | +------------+    |
|     CPU      +<----------------->+                   |
|              |                   |       FPGA        |
|              |                   |                   |
|              |                   |                   |
+--------------+                   +-------------------+


[1] 
https://www.kernel.org/doc/html/latest/driver-api/dmaengine/dmatest.html

Many thanks
Eric
