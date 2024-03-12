Return-Path: <dmaengine+bounces-1344-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CDE87979C
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 16:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A198828482D
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856C7C6C8;
	Tue, 12 Mar 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkeTwepu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC6F4FA;
	Tue, 12 Mar 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257594; cv=none; b=cL3dBscErAhRjl8hMwjFFbvKklZJwZWR+tO9Uq8Eryf1zslse+quaVlrtVKCQnBX17t9axfv29Rf2Ffx23ULOPK1s8o5wqLabjp2ZF4ySUvW8p0UrJ9Auav2EMuEkAG/3ztntP+mrt9qttaOjNv2Ll+84uvWF2l4IyWECLaqSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257594; c=relaxed/simple;
	bh=zBldKUeuDZ8cndWCaJ35EMQR5qhLvUmjXhzazIzp9BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9i5s7TxpLlNPi3HKdol2l1jRhJ03oyHfrneOI5fpe8gu9Y9BI2IpcBdWCDSb7wHv3TqWvsISxVq6WERHUiDB4omwVXIAcberZtKVLnxWHHe02z/a6onEeoDeHb3c+rWkE/r4jHmzhPWibCOTfkoHmcGCOz8Kjert2D/KsHFxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkeTwepu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710257593; x=1741793593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zBldKUeuDZ8cndWCaJ35EMQR5qhLvUmjXhzazIzp9BM=;
  b=XkeTwepuWQ8V5eVKaCZZaa1WfA02q+OhkyXWVgVVwWjoMXirt/LF5HB+
   0jdnLqvqi0DGHheZajdKmdzXxfAJMZOnorMOS8LtCKcQNDe2Fdu+Ff0XC
   Qppg55SrwF8IeKiuOfixqi4DefK5P1seevBWDkEVcV7npoN9T6slxJKeo
   AYSeX1rBUEABAuFdKZpoLxpYORtikAkV5ld4+vq1zh2NDA1/RGcggfIKI
   +0PUD9tnRgpQwNfXAEVS0ffPeD/c72cdFOahVRk/FUOUiBqI0ORhQgWXF
   ik+l04Ch7GmmCP8WvlXN5DAdcXDC+2VhO/Wxuahlb1hXTjh2U1TeDPU3w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4826244"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4826244"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914399879"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="914399879"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:33:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rk47n-0000000Bvm2-2qe4;
	Tue, 12 Mar 2024 17:33:07 +0200
Date: Tue, 12 Mar 2024 17:33:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width
 schema
Message-ID: <ZfB1s2Vy8lXCSLme@smile.fi.intel.com>
References: <20240311222522.1939951-1-robh@kernel.org>
 <171025134347.2083269.1302794772701834117.robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171025134347.2083269.1302794772701834117.robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 12, 2024 at 07:49:05AM -0600, Rob Herring wrote:
> On Mon, 11 Mar 2024 16:25:22 -0600, Rob Herring wrote:

...

> My bot found errors

Well done! :-)

-- 
With Best Regards,
Andy Shevchenko



