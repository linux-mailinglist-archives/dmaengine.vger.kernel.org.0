Return-Path: <dmaengine+bounces-10960-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG18HqLMFWq6bwcAu9opvQ
	(envelope-from <dmaengine+bounces-10960-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 18:38:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12D95D9D63
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B1463091C4E
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD00214204;
	Tue, 26 May 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGiJdhLO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27093AEF3D
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811743; cv=none; b=V6uGzgZgTSyNgSS5CftKRhORuQX0egc4GHAhs6dxHzqgKVvaa7IaurOD1SNWkQuk++dl3NF0JVMKtg2GV3omqZzQMx8esQyeiun1ebwRMZgzKxEEX/k9ut1QvtFklP6ofo7Els4I5EGCsig+FY8w48rnrws4hUNrMzQHihQR3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811743; c=relaxed/simple;
	bh=+Aqn+qHJSeqAjO0H7aFJnhkt7Wgvp1QLOykDLoA7Jpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iCFbhNuu3RkYWAkaF4F1vY0f1SEFq0304gI7EgvR9K8hkp7vO+W1VlcEAjAvyfznWXlJPz2UdtNNzcON2srA1pf6s7tUlQmj2N+WYx0I3Ow47WR4K2PEvEn75krvoSI+WPxcp1M5W6HdUmhir0EHRBmyKDm/XSlW3Ofsjy0RRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGiJdhLO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528571F000E9;
	Tue, 26 May 2026 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811742;
	bh=gw8tMCE+T+V1pPC9U/kHqWeMmvHh3vnn4Z1CLoewot0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kGiJdhLOC3NJ00nRsLFj0rHOoV6bBdT3yRAhIfrbcdK1qZC9ygWkx2EAGRGnnm0fn
	 qyxfMq6XYG/byaVa3fcjTHmeunM0CygHqALVEupRpijaiQQqniRR5RlU+va6fmYbfl
	 FSGB+SfBbunalyd/UfkWG8gPKONKCcwZ+NX9Su+cRsnFbn2muyDVW7e0NJkdWWTJ8T
	 4z0NtNgfIuce6hmC8aUmQjDtnjuwgrLLCwopIoUKBnTbfp38DTMnbhMx5Krzn3UuaI
	 p+cjn5MkZ9R293RbPqOqpMzDcfRQ55ociCz31ZaemKDpZwaWv8CfRsymS0rSylfnOD
	 gJGESxA0VRT6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/14] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-11-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-11-08472fdcbf4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 16:09:01 +0000
Message-Id: <20260526160902.528571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10960-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: D12D95D9D63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Invalid explicit cleanup of devm-managed resources causes slab cor=
ruption and double-free vulnerabilities.
--

commit 633f351bd909cf49fe67df70c5d1504f4356decf
Author: Bartosz Golaszewski <brgl@kernel.org>

crypto: qce - Use existing devres APIs in devm_qce_dma_request()

This commit switches the explicit dma_request_chan and kmalloc calls to
their devm_* counterparts in devm_qce_dma_request. It also simplifies the
error handling paths and renames the release action.

> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index d60efb5c26d88..c2602d35baa6a 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -12,7 +12,7 @@
> =20
>  #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
> =20
> -static void qce_dma_release(void *data)
> +static void qce_dma_terminate(void *data)
>  {
>  	struct qce_dma_data *dma =3D data;

[Severity: High]
Does qce_dma_terminate() still call kfree(dma->result_buf) and
dma_release_channel() on the DMA channels?

Looking at the unmodified portion of the function:

static void qce_dma_terminate(void *data)
{
        struct qce_dma_data *dma =3D data;

        dmaengine_terminate_sync(dma->txchan);
        dmaengine_terminate_sync(dma->rxchan);
        dma_release_channel(dma->txchan);
        dma_release_channel(dma->rxchan);
        kfree(dma->result_buf);
}

Since dma->result_buf, dma->txchan, and dma->rxchan are now allocated using
devm_kmalloc() and devm_dma_request_chan() below, won't the devres framework
automatically clean them up during device teardown?

Because devm_add_action_or_reset() adds this callback to the devres list, it
will execute first and manually free these resources. When the devres
framework subsequently cleans up the devm allocations, could this lead to a
double-free and slab corruption?

[ ... ]

> @@ -27,34 +27,22 @@ int devm_qce_dma_request(struct qce_device *qce)
>  {
>  	struct qce_dma_data *dma =3D &qce->dma;
>  	struct device *dev =3D qce->dev;
> -	int ret;
> =20
> -	dma->txchan =3D dma_request_chan(dev, "tx");
> +	dma->result_buf =3D devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BU=
F_SZ, GFP_KERNEL);
> +	if (!dma->result_buf)
> +		return -ENOMEM;
> +
> +	dma->txchan =3D devm_dma_request_chan(dev, "tx");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-qcom-qce-c=
md-descr-v19-0-08472fdcbf4a@oss.qualcomm.com?part=3D11

