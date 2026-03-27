Return-Path: <dmaengine+bounces-9697-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAPICeq8xmnoNwUAu9opvQ
	(envelope-from <dmaengine+bounces-9697-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 18:22:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 378CA348409
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 18:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C9F63004DD5
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D33793AA;
	Fri, 27 Mar 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="kjPyk9+H"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB4C175A9E
	for <dmaengine@vger.kernel.org>; Fri, 27 Mar 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632167; cv=none; b=hANf4hW4Zu6fWOSiXA3tyS/wZeVRsPnuxj13UQkIyiKkN75dtNCkn/JPA+okDcQBnDgjET8bip10OQcE/gihLc5VOFZoKHcYFRaNcMAHhFeBYlG5/7DYxAJMD3OwMCxUKRYA5NaD1Dub74Pzpl3lxAAoekh4NrvYwpSaAJ2GwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632167; c=relaxed/simple;
	bh=CdCeQR2AFyuSi8xWdEZJvBzKgDhHSzAybSaJ/iMyjtY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=hoNZrAto8oc3S1mI1v+YAwdbXXVgTAD6bOq0GJ7KovM2zRsXITs5nGX477DNtXkSwuplgDPZy0a4YNKrGJQ/l6vjhQSYPSnzCDOvOhA4cspAK+oMTmvhlXVMTRAoYX7C402E+aRaWGOIjOTNK0WVNY2/VjD3kwLI0Z/KnQ1APr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=kjPyk9+H; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=eMrtaY4swfy0dwBoAmhYjUbPRvCKoXwa9ndwwqHPgkU=; b=kjPyk9+Hw5bzloHiC7P+VDiuHi
	UWZnPcWHA5Q7pvAp43s/glFnEHCyZBRgYEvaAic62bXTqZSHsFUrkomc21al7TdbtsbU/Ywi26CMi
	+HyzCUzymaZQvxVgYr1vcIChXNQGcb+3kIDGpSJ7eSL9B374uhhOSR1zRciZzzHqaNZm0fL+gkCb+
	YJpy/rh5wgiaahsDxSPyMRPKa9NdLhu7KV3r57nQDbyA/T5bm2wkokH5IxmmH625flrp7ZCvSGmiq
	fTgz7xz5OSXJdpt69SmnEa9WerrfmKB/wTGa2PLziQT8NvJelCjOGb33b614cb64xjaWkPx6y8LQc
	1nxT4VsQ==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.7])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1w6AYX-000000065uo-1Io6;
	Fri, 27 Mar 2026 11:01:10 -0600
Message-ID: <73fcbd17-7163-42d5-b3a7-bd6144f9395c@deltatee.com>
Date: Fri, 27 Mar 2026 11:00:41 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: David Carlier <devnexen@gmail.com>, Kelvin Cao
 <kelvin.cao@microchip.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
References: <20260317083252.13224-1-devnexen@gmail.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260317083252.13224-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: devnexen@gmail.com, kelvin.cao@microchip.com, vkoul@kernel.org, dmaengine@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] dmaengine: switchtec-dma: fix FIELD_GET misuse when
 programming SE threshold
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9697-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[deltatee.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 378CA348409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-03-17 2:32 a.m., David Carlier wrote:
> FIELD_GET(SE_THRESH_MASK, thresh) extracts bits [31:23] from thresh and
> right-shifts them, which is the inverse of the intended operation. Since
> thresh is derived from se_buf_len / 2 (at most 255), bits [31:23] are
> always zero, so the SE threshold is never actually programmed into the
> register.
> 
> Use FIELD_PREP() instead to correctly left-shift thresh into bits [31:23]
> of the valid_en_se register, consistent with the FIELD_PREP usage for
> the perf tuner config just above.
> 
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sorry for the delay for me to look at this, I just got back from vacation.

Butt yes this looks correct.

Thanks for the quick catch on that mistake!

Review-by: Logan Gunthorpe <logang@deltatee.com>


