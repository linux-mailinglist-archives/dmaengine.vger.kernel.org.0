Return-Path: <dmaengine+bounces-11857-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id do35LTtGQmr+3QkAu9opvQ
	(envelope-from <dmaengine+bounces-11857-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:17:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E16D8CB1
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:17:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SKpbZdOk;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11857-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11857-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5394C302F412
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F002FE59C;
	Mon, 29 Jun 2026 10:15:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B003E2767
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:15:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728107; cv=none; b=LmDuI412dxBgUfLssWXlZ4Aq7s2B2Rj2TjUZaj8fnoPMs5e8Szf/+WV8VJf3n2FW3SDXAFTODh3Nv7hEq0JVQlbPwnByaNwEfDtJ6kCCjyRTm5mFqh1WyLDHSVucrlLJAnkO6j3mkmi8rM9gaIUgjd5/gvTYm3RulU1rsXpRVYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728107; c=relaxed/simple;
	bh=SJcY/ytpz3Hmfq2d6s/yeyuwvoFAadQ6gH82YnBkNaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bw9/4gN9hIg9zlKA6zwWbSajhkNbkLdEerYbplj0bmOh9lAHgcxWF6r9+qP0HepmQwW1tLcJcyboZGRI520eKxciwONy+VpKrhdEcQMIZNm15GVYIJnKQI2rYs5QCzD5SubzE34nmzBMUTqQ7cOh/PkK87rO4wL2B3P5A+8bvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKpbZdOk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB7F1F000E9;
	Mon, 29 Jun 2026 10:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728106;
	bh=kCp+XPekm/Ivysony92IOorHESUmE7e+gXTjhEEi3Fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SKpbZdOkX9wnLQUwSXufhO6eqKMh4hExg3Q6fZ8x44vIQMFc8RtfOWvIG/UjdPWvY
	 VD5XboYEPbXC+Nt7pAYEGbHn2IRuDGFxn+dh2V4SuLhuHxM94ZrocFCTGmwwtnWEvL
	 bpEfZLlR9Qxh7LQogRfUC3RFceK9sgyQqAGVPlRWVD4B2wKjPVpwB7Vc8BpmxlSe4g
	 65GJ1Ad+ggc04oy4EneRSS4VR2WdMVQ0xUC3OQzO2ZTpXt1zDbnYlFOydYrHFLmCxt
	 MdGUtPBcAN0gOSzNupuqUWDF+dDBlnjK/bm9/ib7TBu4LligazQkU8nb+BK3FMidrB
	 5+IJlg5QkOqMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 07/14] crypto: qce - Cancel work on device detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-7-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
 <20260629-qcom-qce-cmd-descr-v20-7-56f67da84c05@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:15:04 +0000
Message-Id: <20260629101505.2CB7F1F000E9@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11857-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,qualcomm.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D6E16D8CB1

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect devres registration order causes Use-After-Free and Use-=
After-Destroy during device unbind.
- [High] Canceling the workqueue without completing pending requests causes=
 a system hang.
--

commit bbc1062dac800956a5d7f42e6fe7594986dd0251
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

crypto: qce - Cancel work on device detach

The workqueue is setup in probe() but never cancelled on error or in
remove(). Set up a devres action to clean it up early, ensuring work is
not cancelled before outstanding DMA transfers terminate.

Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-94=
5fd1cafbbc%40oss.qualcomm.com?part=3D7

> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index b966f3365b7de..f671946cf7351 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -186,6 +186,13 @@ static int qce_check_version(struct qce_device *qce)
>  	return 0;
>  }
> =20
> +static void qce_cancel_work(void *data)
> +{
> +	struct work_struct *work =3D data;
> +
> +	cancel_work_sync(work);

[Severity: High]
If the work is cancelled here, does the active crypto request get leaked?

If a DMA transfer completes and schedules the work, but the device unbinds
before the work executes, cancel_work_sync() will discard the pending work
item. Since qce_cancel_work() does not implement a fallback to propagate an
error completion (like -ESHUTDOWN) to the active crypto request,
crypto_request_complete() is never called.

Will upstream callers of the crypto API waiting on the request hang
indefinitely, potentially causing a system lockup?

> +}
> +
>  static int qce_crypto_probe(struct platform_device *pdev)
>  {

[ ... ]

> @@ -227,6 +234,11 @@ static int qce_crypto_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> +	INIT_WORK(&qce->done_work, qce_req_done_work);
> +	ret =3D devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D devm_qce_dma_request(qce->dev, &qce->dma);

[Severity: High]
Will this devres registration order cause a use-after-free and
use-after-destroy during device unbind?

Devres executes actions in LIFO order. Because qce_cancel_work is registered
here before devm_qce_dma_request() and devm_mutex_init() (which happens lat=
er
in qce_crypto_probe), the teardown sequence will be:

1. Destroy qce->lock
2. Terminate and free DMA channels
3. Wait for the workqueue via cancel_work_sync()

If a DMA callback schedules qce->done_work just before teardown,
qce_req_done_work() could execute while cancel_work_sync() is waiting.
Does this allow the work item to attempt to lock the already destroyed
qce->lock and access the freed DMA channels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-qcom-qce-c=
md-descr-v20-0-56f67da84c05@oss.qualcomm.com?part=3D7

