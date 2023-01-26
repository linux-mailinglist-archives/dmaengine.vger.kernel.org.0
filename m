Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8C67D1CF
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jan 2023 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjAZQh7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Jan 2023 11:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjAZQh6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Jan 2023 11:37:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09139EF3;
        Thu, 26 Jan 2023 08:37:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v10so2376489edi.8;
        Thu, 26 Jan 2023 08:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ba5cFZhUOzaOsPfqAcMSAS/5p9S0Ef5FoHpveVIzFQg=;
        b=HF4dzpXwZKqVgCXVyxN0aUslmZUcvxNmtYq6qSLG2fcFQZ+m4XeENyOHoIexXCmpDc
         t+upru21CqzpMnr5fLB7R6Gyx0WSE8uHGnrtseR+XMc4LID67NaIUn1N84+k7EubyMM2
         IOpW2Ab9IM9hMZBjCox7ihSyWIk2g09QIWQMkdGfsyr6gd5noiYuM1eLVWklEjpyPKOi
         6q5HK1td8j3qT5EiUJdeF2mbpA6+wck9ndCs+jBQgZ820jdCzJLQzDJjctIEn1JnNc25
         yDI2o3MLlwlJmG5ZQt119/8tQjzu0jSL+ZqOOT1EXuy2ZZk4jj1fnKrX1Nc7zTCqmvOi
         EBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba5cFZhUOzaOsPfqAcMSAS/5p9S0Ef5FoHpveVIzFQg=;
        b=JZ7yW0936uffwWJwKLFpMl1dNvoG2igGauDAEYWy2nyq+Q7EihMHBg70oovq02ICpQ
         Dnjw4L5mAxeu/TbmqSnbyGrDelzwwVi14CPUMusmME11CfcfjvoqaZLdGngKzdngTTgg
         P96HVD5ND4MH9r3mGx1cnz4R7wbV16rGM4Qc+plie0eUuO9wL2Zc6Kfzf2/2QxVy/ZCo
         rSQ6Ye+W19U4i0fkUF88599Qn3yqbktE2rINkIALnpAlsSp9o5XKILV/i8hcUHpIfkop
         AShd9oaOcp76YW53o/SPfnHYp1ZUpzU3+DTZ98aOGQbVCTsgz8bYT529oWJZsZKap/kx
         oXgQ==
X-Gm-Message-State: AO0yUKXM6ywCwnCtRApTVRdwMw3/IGLvX1MuyywGMfOdOYQBnR8Pjoew
        uq3qpS8+NSzArgWqrAf6/Hw=
X-Google-Smtp-Source: AK7set/buHMVABqu1LV6shr4i38rA2jpcbKkMBTzMkO+vJK7COrBEMmLZ4VoZTbBkYPgFi/CniKmCw==
X-Received: by 2002:a05:6402:298c:b0:49f:a3d7:b84d with SMTP id eq12-20020a056402298c00b0049fa3d7b84dmr12651880edb.34.1674751074293;
        Thu, 26 Jan 2023 08:37:54 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7d80a000000b00499c377b463sm961914edq.47.2023.01.26.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:37:53 -0800 (PST)
Date:   Thu, 26 Jan 2023 19:37:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230126163750.ae6z3pkyd3o32byn@mobilestation>
References: <20230125144019.sn7kliw3qlwgtwzs@mobilestation>
 <20230125232357.GA1176625@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jmygqfxykzmay6uj"
Content-Disposition: inline
In-Reply-To: <20230125232357.GA1176625@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--jmygqfxykzmay6uj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2023 at 05:23:57PM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 25, 2023 at 05:40:19PM +0300, Serge Semin wrote:
> > On Tue, Jan 24, 2023 at 05:47:44PM -0600, Bjorn Helgaas wrote:
> 
> > > In the commit log, I think "forcibly selecting the DW eDMA driver from
> > > the DW PCIe RP/EP kconfig" actually refers to just the "DW eDMA PCIe"
> > > driver" not the "DW PCIe RP/EP driver," right?
> > 
> > Right.
> 
> Good.  I think it's worth updating the commit log to clear this up
> because there are several things with very similar names, so it's
> confusing enough already ;)
> 
> > > The undefined reference to dw_edma_probe() doesn't actually happen
> > > unless we merge 27/27 without *this* patch, right? 
> > 
> > Right.
> 
> Thanks, I got unreasonably focused on the "fix 'undefined reference'
> error" comment, wondering if we needed to identify a Fixes: commit, so
> this clears that up, too.
> 
> > > I would use "depends on
> > >      DW_EDMA" instead of adding if/endif around DW_EDMA_PCIE.
> > 
> > Could you explain why is the "depends on" operator more preferable
> > than if/endif? In this case since we have a single core kconfig from
> > which all the eDMA LLDD config(s) (except PCIE_DW for the reason
> > previously described) will surely depend on, using if/endif would
> > cause the possible new eDMA-capable LLDD(s) adding their kconfig
> > entries within the if-endif clause without need to copy the same
> > "depends on DW_EDMA" pattern over and over. That seems to look a bit
> > more maintainable than the alternative you suggest. Do you think
> > otherwise?
> 
> Only that "depends on" is much more common and I always try to avoid
> unusual constructs.  But I wasn't looking into the future and
> imagining several LLDDs with similar uses of "depends on DW_EDMA".
> Thanks for that perspective; with it, I think it's OK either way.
> 
> > > What do you think? 
> > 
> > What you described was the second option I had in mind for the update
> > to look like, but after all I decided to take a shorter path and
> > combine the modifications into a single patch. If you think that
> > splitting it up would make the update looking simpler then I'll do as
> > you suggest. But in that case Lorenzo will need to re-merge the
> > updated patchset v10.
> 

> It's a pretty trivial update, so I just did it myself.  The result is
> at https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/ctrl/dwc&id=ecadcaed4ef7
> 
> I split this patch and tweaked some commit messages for consistency
> (including the "DW eDMA PCIe driver" change above).  "git diff -b"
> with Lorenzo's current branch (95624672bb3e ("PCI: dwc: Add DW eDMA
> engine support")) is empty except for a minor comment change.  

Great! Thanks. Although I've already created v10 beforehand but didn't
submitted it yet waiting for your response. The split up patches look
exactly like yours.

In addition to that since I was going to re-send v10 I also took into
account your comments regarding the patch:
[PATCH v9 19/27] dmaengine: dw-edma: Use non-atomic io-64 methods
Link: https://lore.kernel.org/linux-pci/20230113171409.30470-20-Sergey.Semin@baikalelectronics.ru/
I've dropped unneeded modification and unpinned another fixes patch
which turned out to be a part of those modifications. So if you
re-based your pci/ctrl/dwc branch with that patch replaced with the
patches attached to this email it would have been great. Otherwise
it's ok to merge the series as is.

Note in the attached "non-atomic io-64" patch I've already replaced
the commit log with the your short version.

-Sergey

> 
> Bjorn

--jmygqfxykzmay6uj
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="v10-0019-dmaengine-dw-edma-Fix-return-value-truncation-in.patch"

From 4c7dd293e8a9d0139f8bd666c13b545e57d7c16b Mon Sep 17 00:00:00 2001
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date: Wed, 25 Jan 2023 18:19:00 +0300
Subject: [PATCH v10 19/29] dmaengine: dw-edma: Fix return value truncation in
 readq_ch()

The denoted method returns the u64 value meanwhile the local variable
utilized for that is defined as u32. Thus even though the requested
address is accessed by the readq() method the retrieved data will be
truncated to dword. Fix that by changing the local variable type to u64
thus preventing the data truncation.

Note the method is currently unused. That's why the bug hasn't caused any
problem so far.

Fixes: 04e0a39fc10f ("dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v10:
- This update was detached from the v9 patch:
Link: https://lore.kernel.org/linux-pci/20230113171409.30470-20-Sergey.Semin@baikalelectronics.ru
  (@Bjorn)
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 66f296daac5a..13f40560571b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -192,7 +192,7 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			   const void __iomem *addr)
 {
-	u32 value;
+	u64 value;
 
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
-- 
2.39.0


--jmygqfxykzmay6uj
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="v10-0020-dmaengine-dw-edma-Use-non-atomic-io-64-methods.patch"

From 9ddab89a6c92b5518e546c4a6f7cb45e1832cba5 Mon Sep 17 00:00:00 2001
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date: Tue, 1 Feb 2022 23:46:14 +0300
Subject: [PATCH v10 20/29] dmaengine: dw-edma: Use non-atomic io-64 methods

Instead of splitting 64-bits IOs up into two 32-bits ones, use the existing
non-atomic readq()/writeq() functions. By doing so we can discard
CONFIG_64BIT #ifdefs from the code.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>

---

Changelog v10:
- Disacrd the writeq_ch() and readq_ch() methods modification. It's not
  that valuable as it used to seem like in the initial patch. (@Bjorn)
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 32 +++++----------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 13f40560571b..6bcc57512258 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -8,6 +8,8 @@
 
 #include <linux/bitfield.h>
 
+#include <linux/io-64-nonatomic-lo-hi.h>
+
 #include "dw-edma-core.h"
 #include "dw-edma-v0-core.h"
 #include "dw-edma-v0-regs.h"
@@ -53,8 +55,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 		SET_32(dw, rd_##name, value);		\
 	} while (0)
 
-#ifdef CONFIG_64BIT
-
 #define SET_64(dw, name, value)				\
 	writeq(value, &(__dw_regs(dw)->name))
 
@@ -80,8 +80,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 		SET_64(dw, rd_##name, value);		\
 	} while (0)
 
-#endif /* CONFIG_64BIT */
-
 #define SET_COMPAT(dw, name, value)			\
 	writel(value, &(__dw_regs(dw)->type.unroll.name))
 
@@ -164,8 +162,6 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define SET_LL_32(ll, value) \
 	writel(value, ll)
 
-#ifdef CONFIG_64BIT
-
 static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u64 value, void __iomem *addr)
 {
@@ -225,8 +221,6 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define SET_LL_64(ll, value) \
 	writeq(value, ll)
 
-#endif /* CONFIG_64BIT */
-
 /* eDMA management callbacks */
 void dw_edma_v0_core_off(struct dw_edma *dw)
 {
@@ -325,19 +319,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		/* Transfer size */
 		SET_LL_32(&lli[i].transfer_size, child->sz);
 		/* SAR */
-		#ifdef CONFIG_64BIT
-			SET_LL_64(&lli[i].sar.reg, child->sar);
-		#else /* CONFIG_64BIT */
-			SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
-			SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
-		#endif /* CONFIG_64BIT */
+		SET_LL_64(&lli[i].sar.reg, child->sar);
 		/* DAR */
-		#ifdef CONFIG_64BIT
-			SET_LL_64(&lli[i].dar.reg, child->dar);
-		#else /* CONFIG_64BIT */
-			SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
-			SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
-		#endif /* CONFIG_64BIT */
+		SET_LL_64(&lli[i].dar.reg, child->dar);
+
 		i++;
 	}
 
@@ -349,12 +334,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	/* Channel control */
 	SET_LL_32(&llp->control, control);
 	/* Linked list */
-	#ifdef CONFIG_64BIT
-		SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
-	#else /* CONFIG_64BIT */
-		SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
-		SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));
-	#endif /* CONFIG_64BIT */
+	SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
 }
 
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-- 
2.39.0


--jmygqfxykzmay6uj--
