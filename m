Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA412D5650
	for <lists+dmaengine@lfdr.de>; Sun, 13 Oct 2019 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfJMNFA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Oct 2019 09:05:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:46834 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfJMNFA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 13 Oct 2019 09:05:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 06:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,292,1566889200"; 
   d="scan'208";a="185243091"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Oct 2019 06:04:55 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iJdYN-000Aof-A8; Sun, 13 Oct 2019 21:04:55 +0800
Date:   Sun, 13 Oct 2019 21:04:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Green Wan <green.wan@sifive.com>
Cc:     kbuild-all@lists.01.org, linux-hackers@sifive.com,
        Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] dmaengine: sf-pdma: sf_pdma_disclaim_chan() can be static
Message-ID: <20191013130447.2t2hbjcaatguytm3@332d0cec05f4>
References: <20191003090945.29210-4-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003090945.29210-4-green.wan@sifive.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Fixes: 31c3b98b5a01 ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 sf-pdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 70197ad95c1a6..973ed9d8cfa44 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -97,14 +97,14 @@ static void sf_pdma_fill_desc(struct sf_pdma_chan *chan,
 	writeq(src, regs->src_addr);
 }
 
-void sf_pdma_disclaim_chan(struct sf_pdma_chan *chan)
+static void sf_pdma_disclaim_chan(struct sf_pdma_chan *chan)
 {
 	struct pdma_regs *regs = &chan->regs;
 
 	writel(PDMA_CLEAR_CTRL, regs->ctrl);
 }
 
-struct dma_async_tx_descriptor *
+static struct dma_async_tx_descriptor *
 	sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,
 				dma_addr_t dest,
 				dma_addr_t src,
