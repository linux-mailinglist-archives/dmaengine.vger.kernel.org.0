Return-Path: <dmaengine+bounces-10215-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHIVMOiX+WmB+AIAu9opvQ
	(envelope-from <dmaengine+bounces-10215-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 09:10:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7254C7909
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 09:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A84E53067ED5
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 07:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916DE3DCDBE;
	Tue,  5 May 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7DPcfZX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E03DCD90;
	Tue,  5 May 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964497; cv=none; b=j8gPmKQ4vpZNWKK2kUdHRWp66OY9FEF7Vba4PHHAQiV62bkkRGQ9lLZk/Jk4pLK1q6AIsi8nu3tZqNRlHoFfqRyufW5pWNlA5+lhH4H/aLUwnMWPCVroYn1JDqqZLUNQj+KdHpk5scmQ9cfXOiKVTB3D6ffwDS6njLfNxDlvdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964497; c=relaxed/simple;
	bh=I+sI9pNh1K+eb8eKCS5VMu8GQzxKOwuD2JJK/Sruj2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBMyb/FHSXFgUU73T/sQnozwqjiNMgOfE/a2aq1+OjBSrvPP5F5gr3hmt5/VJ9du81iqGj73tL8O86jiETQviziEkxp9Vfv5q1nvEWC7hlNI+HD/dEYDlZDvyiyotOA38dQS+H57gSUS6xw2YT/W3e7Ot6mAF5fEgm9Z+Wkx5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7DPcfZX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777964496; x=1809500496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I+sI9pNh1K+eb8eKCS5VMu8GQzxKOwuD2JJK/Sruj2M=;
  b=P7DPcfZXm5lnltRPGS2o1WGoR2dmd2lCGInXuxDEQnMLRgmcLGKLE3AB
   CbBfWn+Y7KN4QPVYUgzvsHXJz4usw3CAL9NMunIISvbzfC57E61WsPSoA
   ZrAv1YMUzh57wCn6+FJ94OVBFgMKfUFok8vosaQST7Fb4eCeeDJlZQVGj
   sVnLwGqlO3e1lfEIyvRK6AHbnoGOQeQ9/iUcEgi+3LE/yE8sEkY1csPb3
   J3/kGqjTY/GtzkfBPJkd7ToeyRdXRlV0czbPBQH5UU8bAosfzuKwn3Sv8
   SIU6tamBJSHux4tRcL08ea//UyvXoxwLXXdpI5uFwCbXzsZEzp/i1LchO
   A==;
X-CSE-ConnectionGUID: Pxn+k9xWTVSQXgIpUiIAPQ==
X-CSE-MsgGUID: 314w15SlQcC7hfDmbnq8kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90201475"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="90201475"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:01:35 -0700
X-CSE-ConnectionGUID: Yz+4oSulSnm+q0gHxNWEKg==
X-CSE-MsgGUID: 0NgsJsT/Sky8CYks0LSW6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240724865"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:01:34 -0700
Date: Tue, 5 May 2026 10:01:30 +0300
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
Message-ID: <afmVyj5LL83LKeUK@ashevche-desk.local>
References: <20260504102008.1996139-2-u.kleine-koenig@baylibre.com>
 <afh0-BSmchvY-W-d@ashevche-desk.local>
 <afijNvdU6HPbjDCX@monoceros>
 <afioswWDnEbf53ay@ashevche-desk.local>
 <afjJ0YjzLgk-r9Nh@monoceros>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afjJ0YjzLgk-r9Nh@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 6D7254C7909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10215-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ashevche-desk.local:mid,intel.com:dkim]

On Mon, May 04, 2026 at 06:38:51PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> On Mon, May 04, 2026 at 05:09:55PM +0300, Andy Shevchenko wrote:
> > On Mon, May 04, 2026 at 03:55:00PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > On Mon, May 04, 2026 at 01:29:12PM +0300, Andy Shevchenko wrote:
> > > > On Mon, May 04, 2026 at 12:20:06PM +0200, Uwe Kleine-König (The Capable Hub) wrote:

...

> > > > >  static const struct pci_device_id pch_dma_id_table[] = {
> > > > > -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), 8 },
> > > > > -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), 4 },
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), 8}, /* UART Video */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), 8}, /* PCMIF SPI */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), 4}, /* FPGA */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), 12}, /* I2S */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), 4}, /* UART */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), 4}, /* Video SPI */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), 4}, /* Security */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), 4}, /* FPGA */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), 8}, /* UART */
> > > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
> > > > > -	{ 0, },
> > > > > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), .driver_data = 8 },
> > > > > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data = 4 },
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), .driver_data = 8 },		/* UART Video */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), .driver_data = 8 },		/* PCMIF SPI */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), .driver_data = 4 },		/* FPGA */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), .driver_data = 12 },	/* I2S */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), .driver_data = 4 },		/* UART */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), .driver_data = 4 },		/* Video SPI */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), .driver_data = 4 },		/* Security */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), .driver_data = 4 },		/* FPGA */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), .driver_data = 8 },		/* UART */
> > > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), .driver_data = 4 },		/* SPI */
> > > > > +	{ },
> > > > >  };
> > > > 
> > > > Use PCI_DEVICE_DATA() instead. Same may apply to DesignWare, but one needs to
> > > > define the device IDs. I think I may help with that.
> > > 
> > > I'm not a fan of PCI_DEVICE_DATA. While it could indeed be used to
> > > shorten the assignments here, it's less readable in my opinion.
> > 
> > I'm not fun of these long unreadable lines with tons of repetitions :-)
> 
> Seems to be subjective.
> 
> > > Compare
> > > 
> > > 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data = 4 },
> > > 
> > > with
> > > 
> > > 	{ PCI_DEVICE_DATA(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH, 4) },
> > 
> > First of all, with
> > 
> > 	{ PCI_DEVICE_DATA(INTEL, EG20T_PCH_DMA_4CH, 4) },
> 
> Agreed. That doesn't considerably weaken my reasoning however.
> 
> > > . For someone who doesn't know what PCI_DEVICE_DATA does, the latter is
> > > less understandable.
> > 
> > Same applicable to many other macros. I don't consider this argument viable.
> 
> Also agreed. But other bad macros don't justify using that (admittedly
> subjectively) bad PCI_DEVICE_DATA macro that mixes device identity
> (.vendor, .device, .subvendor and .subdevice) with a driver specific
> struct member.
> 
> > > Also PCI_DEVICE_DATA has a cast which is something I want to get rid of.
> > 
> > Yes, and you will get rid of in one place instead of tons of them.
> 
> This would require another (subjectively bad) macro PCI_DEVICE_DATAPTR.
> I think I let someone else tackle that quest.

No, it wouldn't. Since we support C11, we have _Generic(). It may be used.
And please use PCI_DEVICE_DATA() in this driver.

-- 
With Best Regards,
Andy Shevchenko



