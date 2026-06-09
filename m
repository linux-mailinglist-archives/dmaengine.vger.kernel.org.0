Return-Path: <dmaengine+bounces-11354-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G5OREIdwKGoREwMAu9opvQ
	(envelope-from <dmaengine+bounces-11354-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:59:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8616E663FAF
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:59:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gluLioSu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11354-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11354-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4042D3094B06
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06573C108B;
	Tue,  9 Jun 2026 19:55:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4114331EC2;
	Tue,  9 Jun 2026 19:55:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034909; cv=none; b=CAc4k+5D3W1Dwfx6VWs8f6n/GpmJGcqeCOB4oLIWoovtiYOwb8rzIRlulU8boLkJuiKlBTk0II0ys1weXBCaNVJZUKjyQyL+41f66rVRc+aNSjGUJBelemqw334duN0REQyb/08bfKtH1Q/KEsQHnjRlFlJlCEO2dSpCECpgkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034909; c=relaxed/simple;
	bh=m/z3i0fbsaBqvVw0Ox8WMFd84iLnz92YliJ3Z5hIfZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI23nQ/mEDM3vyzZR2mCZEfBrXwjDSo+sYBwd3rRvZN5LmZ+wccOriM3/xxlcEsieF4GSRpk3XKWeDuq4ci4X81SG1gAC4OCcw/IR5GDAYw35r59058C26QuMQOnxr/d+jEqqZXHjbBMEdR43WrpVa2lLA7Qx72qpB2kJAI35gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gluLioSu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC1A1F00898;
	Tue,  9 Jun 2026 19:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781034908;
	bh=81tJvxqzlK7/8ZZbvXQTCyj7rNGbXzYNhmDalpdbN0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gluLioSuO+3CDw4ZCW21iDltj2IglNrYooiGNaW5P3+xzpaHTzh+rJTajcWKrI7A3
	 gX3fV2l3zHB2ZwjKHGqGkU9eBxmUjHG+l2iZDfzYCX4B07NtoWEeI4Jfz54VdvZU9h
	 N7TKVuq8JgokX2H9klqsPzdN33b6emhP8NJBPOCifs79wHVYV6RiQ1up7FFopkFFaT
	 dJAWw1sAZ76lI8GmF8Te554qN8d6wZARkTrjZu5PVsKqqWLHsoC2nFx0G0I+YBFLEx
	 QI0GkNX4wwrJcCDmjJ7toLkcMx8CHmdVpn2Csjj5OlW5+1zyEcQRIg8YF/Up5XwP1A
	 eaoX00X9gqMCQ==
Date: Tue, 9 Jun 2026 13:55:05 -0600
From: Tycho Andersen <tycho@kernel.org>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
	Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
	Shivank Garg <shivankg@amd.com>, Stephen Bates <Stephen.Bates@amd.com>, 
	Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 09/23] dmaengine: sdxi: Start functions on probe, stop
 on remove
Message-ID: <aihu-faXvEv56K3v@tycho.pizza>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
 <20260605-sdxi-base-v3-9-4d38ca2bdffe@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-sdxi-base-v3-9-4d38ca2bdffe@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nathan.lynch@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tycho@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-11354-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tycho.pizza:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8616E663FAF

On Fri, Jun 05, 2026 at 07:02:12PM -0500, Nathan Lynch via B4 Relay wrote:
> +static void sdxi_pci_remove(struct pci_dev *pdev)
> +{
> +	pci_disable_sriov(pdev);

I think this should be in patch 3, since that is what introduces
.sriov_configure(), and then this patch adds the additional call to
sdxi_unregister().

Thanks,

Tycho

> +	sdxi_unregister(&pdev->dev);
> +}
> +
>  static const struct pci_device_id sdxi_id_table[] = {
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
>  	{ }
> @@ -73,6 +79,7 @@ static struct pci_driver sdxi_driver = {
>  	.name = "sdxi",
>  	.id_table = sdxi_id_table,
>  	.probe = sdxi_pci_probe,
> +	.remove = sdxi_pci_remove,
>  	.sriov_configure = pci_sriov_configure_simple,
>  };

