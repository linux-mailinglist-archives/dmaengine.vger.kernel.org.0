Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417BE19A624
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2020 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbgDAHTp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Apr 2020 03:19:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbgDAHTo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Apr 2020 03:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fPytuYQ/JdQCWUd22nsWE2zEPawJqmoUpVmAz126Jd8=; b=P4hZJ/gj3h2zcEfGmd64cFKCwQ
        4wzBF643oVaiZbd/OGTJTaKylNCTaYedjOaZD1HoamEFwAcv8X6xtHt8bm11j9rI1JzREUmNfyuZE
        fRVWqnF7T9DQJoC+XYC3zTAEJvqT6uE5uEqaJyXiJv1UMLmimSpa+eaKB8FIQL/N6hjL+Fz32Wipb
        YNDlURRdfG1anocuFqQpa402m2vylh3cQjtYQp2YqDXl7E/4vZ1TovhjRcfin+WX6u9/Rfb8gXcyR
        zZIuAoe4OCAcjBPMJ2r/t5kePEQ6kW2LZRqKA3G9TYaY1IUqQicah9qQzOK8HXUikrrff5gWawFAk
        HA/OAPpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJXex-0002fW-Lk; Wed, 01 Apr 2020 07:19:35 +0000
Date:   Wed, 1 Apr 2020 00:19:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Subject: Re: [PATCH 4/6] device: add cmdmem support for MMIO address
Message-ID: <20200401071935.GB31076@infradead.org>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
 <158560363242.6059.17603442699301479734.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158560363242.6059.17603442699301479734.stgit@djiang5-desk3.ch.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> +/**
> + * devm_cmdmem_remap - Managed wrapper for cmdmem ioremap()
> + * @dev: Generic device to remap IO address for
> + * @offset: Resource address to map
> + * @size: Size of map
> + *
> + * Managed cmdmem ioremap() wrapper.  Map is automatically unmapped on
> + * driver detach.
> + */
> +void __iomem *devm_cmdmem_remap(struct device *dev, resource_size_t offset,
> +				 resource_size_t size)
> +{
> +	if (!device_supports_cmdmem(dev))
> +		return NULL;
> +
> +	return devm_ioremap(dev, offset, size);

All this could be trivially open coded in the caller.
