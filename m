Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCFB45F94A
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 02:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbhK0B02 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Nov 2021 20:26:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346049AbhK0BY0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Nov 2021 20:24:26 -0500
Message-ID: <20211126230524.661169696@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7645zM4jmr/sh6ufNFcrhF4sFIscYYINKeWaqJ1fetg=;
        b=IAGZg4nEuFV633zEHMYdJKOCg7bgw4YrAVFNJUrjZ6yJK/gpmDGk25/L6OOkCASCsXASNR
        WoD0h5u+OkB6oI/XU2UslSdkC5mxlRUYlai18Q/3KTqR9slgbNpd932hDu5FcUUAI4ThFu
        cuwZfRXgRESttb7cVw2IXItRIM7pgioliIXIAVKEuqUCTZmL1AeWTuVEoMBvJw8RGu0ZjL
        kEsObjfMyWDDaBJfcV9gZO4y6DiXQ/wZkSUrZVV5vbRKvgYcPUDoyA5QtEQYfd4VYZF18y
        MoKnB6dtm645MX86nUSGcnIC+S81YOgtr3B1CzkN6tsKsdahgnK2wNKN+SXUBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7645zM4jmr/sh6ufNFcrhF4sFIscYYINKeWaqJ1fetg=;
        b=TLo9yqN9MqnxrgYUmD761QTMbiItfPBJoAiz5YYue8yjXytxOqW2NlXOECM+lmVUFx2gew
        elfrS7MJTlOqQCBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 12/37] platform-msi: Rename functions and clarify comments
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:20:26 +0100 (CET)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's hard to distinguish what platform_msi_domain_alloc() and
platform_msi_domain_alloc_irqs() are about. Make the distinction more
explicit and add comments which explain the use cases properly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c     |   36 +++++++++++++++++++++---------------
 drivers/irqchip/irq-mbigen.c    |    4 ++--
 drivers/irqchip/irq-mvebu-icu.c |    6 +++---
 include/linux/msi.h             |    8 ++++----
 4 files changed, 30 insertions(+), 24 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -313,17 +313,18 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_fr
  *                              a platform-msi domain
  * @domain:	The platform-msi domain
  *
- * Returns the private data provided when calling
- * platform_msi_create_device_domain.
+ * Return: The private data provided when calling
+ * platform_msi_create_device_domain().
  */
 void *platform_msi_get_host_data(struct irq_domain *domain)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
+
 	return data->host_data;
 }
 
 /**
- * __platform_msi_create_device_domain - Create a platform-msi domain
+ * __platform_msi_create_device_domain - Create a platform-msi device domain
  *
  * @dev:		The device generating the MSIs
  * @nvec:		The number of MSIs that need to be allocated
@@ -332,7 +333,11 @@ void *platform_msi_get_host_data(struct
  * @ops:		The hierarchy domain operations to use
  * @host_data:		Private data associated to this domain
  *
- * Returns an irqdomain for @nvec interrupts
+ * Return: An irqdomain for @nvec interrupts on success, NULL in case of error.
+ *
+ * This is for interrupt domains which stack on a platform-msi domain
+ * created by platform_msi_create_irq_domain(). @dev->msi.domain points to
+ * that platform-msi domain which is the parent for the new domain.
  */
 struct irq_domain *
 __platform_msi_create_device_domain(struct device *dev,
@@ -372,18 +377,19 @@ struct irq_domain *
 }
 
 /**
- * platform_msi_domain_free - Free interrupts associated with a platform-msi
- *                            domain
+ * platform_msi_device_domain_free - Free interrupts associated with a platform-msi
+ *				     device domain
  *
- * @domain:	The platform-msi domain
+ * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the free operation
  * @nvec:	How many interrupts to free from @virq
  */
-void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nvec)
+void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nvec)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
 	struct msi_desc *desc, *tmp;
+
 	for_each_msi_entry_safe(desc, tmp, data->dev) {
 		if (WARN_ON(!desc->irq || desc->nvec_used != 1))
 			return;
@@ -397,10 +403,10 @@ void platform_msi_domain_free(struct irq
 }
 
 /**
- * platform_msi_domain_alloc - Allocate interrupts associated with
- *			       a platform-msi domain
+ * platform_msi_device_domain_alloc - Allocate interrupts associated with
+ *				      a platform-msi device domain
  *
- * @domain:	The platform-msi domain
+ * @domain:	The platform-msi device domain
  * @virq:	The base irq from which to perform the allocate operation
  * @nr_irqs:	How many interrupts to free from @virq
  *
@@ -408,8 +414,8 @@ void platform_msi_domain_free(struct irq
  * with irq_domain_mutex held (which can only be done as part of a
  * top-level interrupt allocation).
  */
-int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nr_irqs)
+int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
 	int err;
@@ -421,7 +427,7 @@ int platform_msi_domain_alloc(struct irq
 	err = msi_domain_populate_irqs(domain->parent, data->dev,
 				       virq, nr_irqs, &data->arg);
 	if (err)
-		platform_msi_domain_free(domain, virq, nr_irqs);
+		platform_msi_device_domain_free(domain, virq, nr_irqs);
 
 	return err;
 }
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -207,7 +207,7 @@ static int mbigen_irq_domain_alloc(struc
 	if (err)
 		return err;
 
-	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
+	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
 	if (err)
 		return err;
 
@@ -223,7 +223,7 @@ static int mbigen_irq_domain_alloc(struc
 static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs)
 {
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 }
 
 static const struct irq_domain_ops mbigen_domain_ops = {
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -221,7 +221,7 @@ mvebu_icu_irq_domain_alloc(struct irq_do
 		icu_irqd->icu_group = msi_data->subset_data->icu_group;
 	icu_irqd->icu = icu;
 
-	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
+	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
 	if (err) {
 		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
 		goto free_irqd;
@@ -245,7 +245,7 @@ mvebu_icu_irq_domain_alloc(struct irq_do
 	return 0;
 
 free_msi:
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 free_irqd:
 	kfree(icu_irqd);
 	return err;
@@ -260,7 +260,7 @@ mvebu_icu_irq_domain_free(struct irq_dom
 
 	kfree(icu_irqd);
 
-	platform_msi_domain_free(domain, virq, nr_irqs);
+	platform_msi_device_domain_free(domain, virq, nr_irqs);
 }
 
 static const struct irq_domain_ops mvebu_icu_domain_ops = {
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -432,10 +432,10 @@ struct irq_domain *
 #define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
 	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
 
-int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nr_irqs);
-void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
-			      unsigned int nvec);
+int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nr_irqs);
+void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
+				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 

