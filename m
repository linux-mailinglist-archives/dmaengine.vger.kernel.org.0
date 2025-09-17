Return-Path: <dmaengine+bounces-6601-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CECB7F760
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 15:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB344A6C26
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B531BCBD;
	Wed, 17 Sep 2025 13:34:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC431A7EE;
	Wed, 17 Sep 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116056; cv=none; b=fLf4hpVKr5x4KiTKd1cbzSbKf4IfooUn8ob/emenaYW8y2Gs5Asgr5rgLO8Dn6EIrtk4D7InMPbPOvGYZBuZmQD3afuPpavD9YTagtH9/Zl+jHHfve6COgfmVaUHza7kEDCwHil1/8N4Zum4HuTUDBEBgRZphHjrik5R9dDd9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116056; c=relaxed/simple;
	bh=ioO5mDRtnsQXD0qffG7STW6S+g2YpCQbLNbqPpwEPVo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOKmr4AcCy3V0xODsXLd9nKm4bIRt2V4syJZCL54lLaZqxp9ghrVU6vDBL/pOmKwqxPBIQZfEUb8F0AWWD2GNHSTt1nzOUIQX+9oHPX3ljVCgPLvWv+RcFuG8PxyrJneZZEU2wY5BA+hoOa5SlBKRxh4MiWH/N66eUxKkzvvf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRfkq2Z4yz6DDmL;
	Wed, 17 Sep 2025 21:29:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C2020140371;
	Wed, 17 Sep 2025 21:34:11 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 15:34:11 +0200
Date: Wed, 17 Sep 2025 14:34:10 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch <nathan.lynch@amd.com>
CC: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 08/13] dmaengine: sdxi: Context creation/removal,
 descriptor submission
Message-ID: <20250917143410.00005bb4@huawei.com>
In-Reply-To: <87a52uxhat.fsf@AUSNATLYNCH.amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-8-d0341a1292ba@amd.com>
	<20250915151257.0000253b@huawei.com>
	<87a52uxhat.fsf@AUSNATLYNCH.amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >> +static const char *cxt_sts_state_str(enum cxt_sts_state state)
> >> +{
> >> +	static const char *const context_states[] = {
> >> +		[CXTV_STOP_SW]  = "stopped (software)",
> >> +		[CXTV_RUN]      = "running",
> >> +		[CXTV_STOPG_SW] = "stopping (software)",
> >> +		[CXTV_STOP_FN]  = "stopped (function)",
> >> +		[CXTV_STOPG_FN] = "stopping (function)",
> >> +		[CXTV_ERR_FN]   = "error",
> >> +	};
> >> +	const char *str = "unknown";
> >> +
> >> +	switch (state) {
> >> +	case CXTV_STOP_SW:
> >> +	case CXTV_RUN:
> >> +	case CXTV_STOPG_SW:
> >> +	case CXTV_STOP_FN:
> >> +	case CXTV_STOPG_FN:
> >> +	case CXTV_ERR_FN:
> >> +		str = context_states[state];  
> >
> > I'd do a default to make it explicit that there are other states. If
> > there aren't then just return here and skip the return below. A
> > compiler should be able to see if you handled them all and complain
> > loudly if a new one is added that you haven't handled.  
> 
> The CXTV_... values are the only valid states that an SDXI device is
> allowed to report for a context, but this function is intended to be
> resilient against unspecified values in case of implementation bugs (in
> the caller, or firmware, whatever). That's why it falls back to
> returning "unknown".
> 
> But it's coded without a default label so that -Wswitch (which is
> enabled by -Wall and so is generally active for kernel code) will warn
> on an unhandled case. The presence of a default label will actually
> defeat this unless the compiler is invoked with -Wswitch-enum, which
> even W=1 doesn't enable.
> 
> I really do want warnings on unhandled cases of this sort, so I suppose
> at the very least this code deserves a comment to deter well-meaning
> people from trying to add a default label. Or I could add the default
> label and see how painful it is to use -Wswitch-enum throughout the
> driver. There are several similar functions in the error reporting code
> so this isn't the only instance of this pattern in the driver.

Thanks for the response. Makes sense.

J


