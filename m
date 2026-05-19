Return-Path: <dmaengine+bounces-10551-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MX9COBpDGo8hQUAu9opvQ
	(envelope-from <dmaengine+bounces-10551-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:47:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D93757FF50
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 094A1300D73A
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5227330650;
	Tue, 19 May 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YusHMMGG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BAC19ABD8
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198428; cv=none; b=AXxC6nDwWU+Bp2oTrsTXGDBn7FnPNm7Mn2ye0ngli4pJsvihi1TSLtBy6wpyfYUWNGINZaMRbw4pYqlk4dCE8HIhU/Odm87XFP84NpWr+AOdFuYV/D2aXoM/3bhC0h7i09oA08qch/jHa7tzgxAUPlczgGqG5RX6YagVxGwJFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198428; c=relaxed/simple;
	bh=i1sVpVZ22Y42Nfns/6FiUfViZzyZGyWRyEI49o18iqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/olgm8fPx42th/vomjJBaq1Iia1zxTH8POC3veNWdUXioBbn7FJQqFPfM0usB4fUKnq9o7Gekb1EOpKhTU9jmRXM+xrRRJHr6veylhOVnNd6gxlF0yNIqGibXNRWz/s7jjfTNVn/c/9cU7vJ3TxU8UUezLADkL1uSjS9HAUtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YusHMMGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09803C2BCB3;
	Tue, 19 May 2026 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198428;
	bh=i1sVpVZ22Y42Nfns/6FiUfViZzyZGyWRyEI49o18iqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YusHMMGGfjAeiwKMDksxQg3bh+lqLBn90ZLAAwSxSReNyR4oNVx4dhoXTnkz+WmE+
	 qqTX6hfsUZmLg9rPWWDI6EkMunHsTRVOo07du4dL9058JE6eMEffxtiymz533pssWM
	 kxVmucBTrM2q90XAStluiTqaZ50xpakDvXlNxUPEbORai284/1NTDo11YWTMmeV0Vp
	 kVu7FYgHCDgB1/V60V6ovj19LSOWSSrc0M0qPnC2vNScE+u85uBAaAlqKxettmROih
	 egGKAoEyCIWiVIPJZ05vlHnwanasatfiuOAh1EPstniPBPHRUttNc6e1L5R7anSxjf
	 7pLK1SaBxXV5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/14] crypto: qce - Cancel work on device detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-7-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-7-53a595414b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 13:47:07 +0000
Message-Id: <20260519134708.09803C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10551-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,qualcomm.com:email,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D93757FF50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect devres registration order allows DMA callbacks to schedu=
le work after it has been cancelled, causing a use-after-destroy and use-af=
ter-free on driver unbind.
--

commit 0da71e23ef53eb17f76a32aa2d25f7d24ce0dd3a
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

crypto: qce - Cancel work on device detach

This commit adds a devres action to cancel done_work on device removal or
probe error, ensuring the workqueue is properly cleaned up.

Fixes: eb7986e5e14d ("crypto: qce - convert tasklet to workqueue")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D7

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index b966f3365b7de..e82fc862c74b2 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
[ ... ]
> @@ -240,6 +247,11 @@ static int qce_crypto_probe(struct platform_device *=
pdev)
>  		return ret;
> =20
>  	INIT_WORK(&qce->done_work, qce_req_done_work);
> +
> +	ret =3D devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
> +	if (ret)
> +		return ret;
> +

Since devres cleanup actions execute in reverse order of their registration,
won't qce_cancel_work() be executed before the DMA channels are terminated?

If an active hardware DMA transfer completes immediately after
cancel_work_sync() returns, the DMA completion interrupt could fire. Could
this invoke the DMA callback and schedule_work(&qce->done_work), re-queuing
the work that was just cancelled?

Because the devres teardown will then proceed to destroy the mutex, release
the DMA channels, and free the qce structure, won't this result in a
use-after-free when qce_req_done_work() eventually executes?

Would it be safer to register the cancel action before requesting the DMA
channels via devm_qce_dma_request(), ensuring that the source of
asynchronous events is disabled before the background work is cancelled?

>  	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
> =20
>  	qce->async_req_enqueue =3D qce_async_request_enqueue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-qcom-qce-c=
md-descr-v17-0-53a595414b79@oss.qualcomm.com?part=3D7

