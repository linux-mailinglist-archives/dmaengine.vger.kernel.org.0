Return-Path: <dmaengine+bounces-11616-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /KD1AMucM2oJEQYAu9opvQ
	(envelope-from <dmaengine+bounces-11616-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:22:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5070A69E0D0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:22:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pf9J5lJ1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11616-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11616-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F3C300BDB7
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79613C342F;
	Thu, 18 Jun 2026 07:22:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8842BB17;
	Thu, 18 Jun 2026 07:22:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767368; cv=none; b=bm4CXAmhXdA/HfzYl2UbFpaYOmIdz7Lin6IfCyIFSqcDwYowLL7bgLbGmQ6Xp0Q5wvAgFjhNIxH06xi9OswSR/ezUfi44n/hZOEgJoLyojaDXGvTi282Uim3bSiejMJQCzg+SQWirHnyWNNsm+QdhfF87QVbb6PpSm6UIxP6hXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767368; c=relaxed/simple;
	bh=BWAmPdJS8zm2N3lN0sNlSpkqTauly2NunP8ETdN1sNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BCZ4YkFzVGQ+0P6+xl2SWHyd0o+/S5t9AqdB0xS3Ya8V3g16o1SwdQzIhwf4lZ7lyBq7E4PfkyacevCrjUddvDtvFH+CQeCkShlowEEZHke3yNNYFtJPFPnpsbHETXiBwReG6kThaa2j1/i39OcZpoV53svqG3GzxKFcAkzgwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf9J5lJ1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58441F000E9;
	Thu, 18 Jun 2026 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781767367;
	bh=RfU6DnDGR6cX9KqQoWBCycGMKixF+u+Tk8uGqdMZFA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pf9J5lJ1ElMjov4MaN0JlQFxue+xDYbZihEFDih05iXlMnVGf+TJMIltLj67PsUZZ
	 ou8ByYaXnPY8qdVhrrUPwUE+skvnBvnhU5MC1/tGpKcYu2UUExXqJDYNqFONZRAtoN
	 6UdWlW3FbMqH0iFze+87VUnSsuNsZAYpZMUEaLwBJfIpeMoGKF7CqKGnhJM7pBTglS
	 qom2cg+mx6aYEx5ILgcKRAdiSshooEnH8tNYA15D/5yWDsc44zuXYaPFEy3dHsTQ7s
	 sATYVyQWVMtK1jX6YFtCDpXwveAuArJgk+ils7Z/qgO1E9tj5Z1CXHpm47pnGrPe33
	 tL4oFmx18dGMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/3] dmaengine: zynqmp_dma: Add per-channel reset
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Golla Nagendra" <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260618071056.2024286-3-nagendra.golla@amd.com>
References: <20260618071056.2024286-1-nagendra.golla@amd.com>
 <20260618071056.2024286-3-nagendra.golla@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 07:22:46 +0000
Message-Id: <20260618072246.D58441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11616-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nagendra.golla@amd.com,m:vkoul@kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5070A69E0D0

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using pm_runtime_put_noidle() before pm_runtime_disable() leaves h=
ardware active and leaks clock references on probe deferral.
--

commit 0e5952f6551c9a8d3b55c9a149969bfbe79c7c9c
Author: Golla Nagendra <nagendra.golla@amd.com>

dmaengine: zynqmp_dma: Add per-channel reset support

This commit adds per-channel reset support for Versal Gen 2 and Versal Net
SoCs using device_reset_optional() during channel probe. It also adds a call
to pm_runtime_put_noidle() in the probe error path to balance the usage
counter.

> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_=
dma.c
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
[ ... ]
> @@ -1152,6 +1158,7 @@ static int zynqmp_dma_probe(struct platform_device =
*pdev)
>  err_disable_pm:
>  	if (!pm_runtime_enabled(zdev->dev))
>  		zynqmp_dma_runtime_suspend(zdev->dev);
> +	pm_runtime_put_noidle(zdev->dev);

[Severity: High]
Does using pm_runtime_put_noidle() here instead of pm_runtime_put_sync()
cause a clock leak during probe deferral?

If device_reset_optional() returns -EPROBE_DEFER, pm_runtime_put_noidle()
decrements the usage counter but does not suspend the device. The device
status remains active. When pm_runtime_disable() is called and the probe
fails, the driver core handles the failure by forcefully setting the status
to suspended without calling the driver's runtime suspend callback.

This leaves clk_main and clk_apb enabled. On the next probe retry,
pm_runtime_resume_and_get() will double-enable the clocks.

Should pm_runtime_put_sync() be used before pm_runtime_disable() to ensure
the device is synchronously suspended and clocks are properly disabled?

>  	pm_runtime_disable(zdev->dev);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618071056.2024=
286-1-nagendra.golla@amd.com?part=3D2

