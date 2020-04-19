Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB941AFC1E
	for <lists+dmaengine@lfdr.de>; Sun, 19 Apr 2020 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDSQtS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Apr 2020 12:49:18 -0400
Received: from v6.sk ([167.172.42.174]:43662 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgDSQtS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 19 Apr 2020 12:49:18 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 9A7E5610A6;
        Sun, 19 Apr 2020 16:49:16 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] dmaengine: mmp_tdma: Make the driver actually work
Date:   Sun, 19 Apr 2020 18:49:05 +0200
Message-Id: <20200419164912.670973-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

chained to this message is a couple of improvements to the MMP Audio DMA
driver (mmp_tdma). Please consider applying them.

Patches 1 to 5 are various improvements robustness and error handling.

The most important patch is [PATCH 6/7], which makes the driver play
along with soc-generic-dmaengine-pcm. This is necessary to play sound on 
devicetree-based MMP2 machines.

The last patch drops MMP_SRAM dependency. This is a safe thing to do,
because nothing currently actually uses this (mmp_tdma) driver. There's a
redundant driver in sound/soc/pxa/mmp-pcm.c, which is also effectively
unused. Sigh.

Tested on an OLPC XO-1.75 laptop (along with changes to the MMP SSPA
driver).

Thank you
Lubo



