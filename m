Return-Path: <dmaengine+bounces-3171-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2FA97A283
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 14:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804521F2186E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A1155322;
	Mon, 16 Sep 2024 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lv8oHpT/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C61D555;
	Mon, 16 Sep 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490812; cv=none; b=Snsbc6WKnbtxHv2xJflKL9Zn8AGtFrZdtfrVtQXEHSA0F5MLJk8CXs06N4FRO6uEdyuHBoTdhswlEBHxYC+0BQFgCQN9kdqEYKbEPR7Jua/8k0cF9usK/h37AdkKMKa6BqZI2drnapn5ebFuKbZjiUmBznKWplPh4aV2xq6OikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490812; c=relaxed/simple;
	bh=pDvMc464eWrFnscvDjbF1OV66TiSCOmbPTRkOy7zly0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AN7sHXC5TXYRDV50+FJojpKbrlKuuidlRmZhTQ6BOXG4Woqq6BNFxUpZgWOmKHXyfxKKP3szWWSH49F7CUqEEpnArsX7BcaF9OWNo7MgXB4uPsrQgeiQE85eGtFbuPbA/dgdgrRydkkDhjQBgLFFWPS4cn/3cMEfDr4tJgd7C+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lv8oHpT/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726490811; x=1758026811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pDvMc464eWrFnscvDjbF1OV66TiSCOmbPTRkOy7zly0=;
  b=Lv8oHpT//W/PfuCmcHaUiDtFaa+4YGzPFXSvzST5TOOlOY1lOJ8CbASB
   QY4eXDeH2tpvUN57CeH29WiGJOd190MJxSn7P04YggD74iE8/uacoY6nD
   i99oOPUsGAmXTD3QqEMNaPgQ86UZa+KcdXtBnNRdnk1a+dhFSJrceJ8q7
   OLvWrrjenC4ILeT5xX+Xmkgz5Wk9FajNzdjGSdDabumfY23eSrZZT6+Vy
   E9vGJkf/CnFl71D+Wv2FQ3UTK0dhyAZ0Q2XV2kmBS14LNzEJKPZ8e2EXw
   ETDPFlbB98A6LawltRWWXT43Vf8TAVINQNjiU5Lm99C8cnuNcOCh5zMBY
   g==;
X-CSE-ConnectionGUID: ershSdUXRuac5JHGNGb1+w==
X-CSE-MsgGUID: ySsP8hW0R/WO88wH+T/4zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="42787731"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="42787731"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 05:46:50 -0700
X-CSE-ConnectionGUID: S/iLLSEVTDOkGgDyyta/nw==
X-CSE-MsgGUID: vxsu8NGfRfarT4hIDHUkaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="73451857"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 05:46:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqB7t-00000009Sas-1VlS;
	Mon, 16 Sep 2024 15:46:45 +0300
Date: Mon, 16 Sep 2024 15:46:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Viresh Kumar <vireshk@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/6] dmaengine: dw: Add peripheral bus width
 verification
Message-ID: <ZugotKRM7_zIoMKI@smile.fi.intel.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <20240802075100.6475-2-fancer.lancer@gmail.com>
 <ZuXgI-VcHpMgbZ91@black.fi.intel.com>
 <wghwkx6xbkwxff5wbi2erdl2z3fmjdl54qqb3rfty7oiabvk7h@3vpzlkjataor>
 <ZugZ9NcnPMNTH_ZQ@smile.fi.intel.com>
 <ZugaZbSIFqUujD5r@smile.fi.intel.com>
 <ZugdQyQNhxzaDZpV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZugdQyQNhxzaDZpV@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 16, 2024 at 02:57:56PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 16, 2024 at 02:45:41PM +0300, Andy Shevchenko wrote:

...

> Okay that was the theory, now I made a hack patch, i.e. supply 0 in acpi.c in
> the filter function and everything starts to work. So, my theory is correct.

FWIW, I have reapplied the whole series and it seems fine, so the only regression
is that I described in the previous replies.

-- 
With Best Regards,
Andy Shevchenko



