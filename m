Return-Path: <dmaengine+bounces-10210-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPeiEmKr+Gn2xgIAu9opvQ
	(envelope-from <dmaengine+bounces-10210-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 16:21:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 816214BF2BA
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 16:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C34B6303A2C1
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2026 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B0E3D3334;
	Mon,  4 May 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXaBLVrP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA63A7F4C;
	Mon,  4 May 2026 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903803; cv=none; b=TbHpKykwFqvPi02ouyja6E3nVgQchweEhqb7eGjWIQPXnv+gK7qhLyPJJbKrpQ0m1MOiy7k9ctpZGW0cU5j/fy8cxdNUuROlugNMcA9oYe+8158zzFXGyAiikS4oE7cqE3tRX+iepY3hbitkhkmrHZCKfy8zoQ0n50nl58QTABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903803; c=relaxed/simple;
	bh=z2/U2yaa/7Xu73IQEmB7pwPfpl/JImmdWLS8wyXf3Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STs+qoUaIDgMs/WmG8OKkMHOvnkHI/5QhZjW+QRBtM45a7x+2K5qQxkSOp1/Jz1RE54opRo4s9YXRZENTl4V4fhZYTbUz2Ys8oheOlhMt9CIv48G2AImIpfrdHxN3KpFUVUkz5yY/Gv+7JyAeqsHvZOSBsCmKATitAaCYFRfXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXaBLVrP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777903801; x=1809439801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z2/U2yaa/7Xu73IQEmB7pwPfpl/JImmdWLS8wyXf3Bc=;
  b=BXaBLVrPUyo+gLFpRP6uqLxTittCPWu01hkTmJDHVVYEWWyPM2PypDXJ
   9BHmw+x+xjeUHwt03piFRFyh7RKE4N7ggt36QihzkRNA4CmB9TQW3Nigf
   qzZu4yHM7h7S68V5v6+6mbz9im6vCRMuYPaPgwgsDtI5HALq82q7Y36QY
   aQgce3fSXPSmVkBrZ0qmHGvwjQyC/p7dYd64G21XXqSpzPqKnlsMslEMf
   jONASuWCuaX+w2dd9fJRm6Ll8ffXWijdAMLDExSkPfs1gLKpRin0QUar6
   Ye38lq/zjGqCx/RmmQIzNwpkp4z9u8QlMdVIyfkeENyJQFLjAfAs9GUOZ
   g==;
X-CSE-ConnectionGUID: GyCUF0fUTly5Zx3U2lpgRQ==
X-CSE-MsgGUID: Whu66y+TS7WEz/79H1fXKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90136472"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="90136472"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:10:00 -0700
X-CSE-ConnectionGUID: XWvm6NYdR/uJNleIi738EQ==
X-CSE-MsgGUID: 7RcpfvNMQP2o4dDTbsZrKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235390876"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:09:58 -0700
Date: Mon, 4 May 2026 17:09:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Consistently define pci_device_ids using
 named initializers
Message-ID: <afioswWDnEbf53ay@ashevche-desk.local>
References: <20260504102008.1996139-2-u.kleine-koenig@baylibre.com>
 <afh0-BSmchvY-W-d@ashevche-desk.local>
 <afijNvdU6HPbjDCX@monoceros>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afijNvdU6HPbjDCX@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 816214BF2BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10210-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim]

On Mon, May 04, 2026 at 03:55:00PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> On Mon, May 04, 2026 at 01:29:12PM +0300, Andy Shevchenko wrote:
> > On Mon, May 04, 2026 at 12:20:06PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > The .driver_data member of the various struct pci_device_id arrays were
> > > initialized by list expressions. This isn't easily readable if you're
> > > not into PCI. Using named initializers is more explicit and thus easier
> > > to parse. Also skip explicit assignments of 0 (which the compiler then
> > > takes care of).
> > > 
> > > This change doesn't introduce changes to the compiled pci_device_id
> > > arrays. Tested on x86 and arm64.
> > 
> > HSU driver has different change ("Also" is a strong sign to the split required).
> 
> HSU is in the category "skip explicit assignments of 0", so I think
> that's fine. I could be talked into splitting if that's what is wanted.

Yes, please. I will Rb/Ack it immediately when standalone change.

...

> > >  static const struct pci_device_id pch_dma_id_table[] = {
> > > -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), 8 },
> > > -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), 4 },
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), 8}, /* UART Video */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), 8}, /* PCMIF SPI */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), 4}, /* FPGA */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), 12}, /* I2S */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), 4}, /* UART */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), 4}, /* Video SPI */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), 4}, /* Security */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), 4}, /* FPGA */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), 8}, /* UART */
> > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
> > > -	{ 0, },
> > > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), .driver_data = 8 },
> > > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data = 4 },
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), .driver_data = 8 },		/* UART Video */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), .driver_data = 8 },		/* PCMIF SPI */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), .driver_data = 4 },		/* FPGA */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), .driver_data = 12 },	/* I2S */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), .driver_data = 4 },		/* UART */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), .driver_data = 4 },		/* Video SPI */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), .driver_data = 4 },		/* Security */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), .driver_data = 4 },		/* FPGA */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), .driver_data = 8 },		/* UART */
> > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), .driver_data = 4 },		/* SPI */
> > > +	{ },
> > >  };
> > 
> > Use PCI_DEVICE_DATA() instead. Same may apply to DesignWare, but one needs to
> > define the device IDs. I think I may help with that.
> 
> I'm not a fan of PCI_DEVICE_DATA. While it could indeed be used to
> shorten the assignments here, it's less readable in my opinion.

I'm not fun of these long unreadable lines with tons of repetitions :-)

> Compare
> 
> 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data = 4 },
> 
> with
> 
> 	{ PCI_DEVICE_DATA(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH, 4) },

First of all, with

	{ PCI_DEVICE_DATA(INTEL, EG20T_PCH_DMA_4CH, 4) },

> . For someone who doesn't know what PCI_DEVICE_DATA does, the latter is
> less understandable.

Same applicable to many other macros. I don't consider this argument viable.

> Also PCI_DEVICE_DATA has a cast which is something I want to get rid of.

Yes, and you will get rid of in one place instead of tons of them.

-- 
With Best Regards,
Andy Shevchenko



