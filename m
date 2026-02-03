Return-Path: <dmaengine+bounces-8692-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKV3LsjtgWkFMAMAu9opvQ
	(envelope-from <dmaengine+bounces-8692-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:44:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA7D9365
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 13:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C4D130C26EE
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5633A9CB;
	Tue,  3 Feb 2026 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FFPNAGX2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68BC33C53F;
	Tue,  3 Feb 2026 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122478; cv=none; b=unMtS+xSljGrBdPPkxH07ErI008xWgJBbQwnnCARranxXgLoCOvJxd+7xPQjUkcSjWjKilwD3EExhEKP3B9gbx6QuqIIrjlfEkbmWYSgE9oCsqBxlX4AuVXZaBiLC6j9c3GEhhByCTV1fDK1MzZQ54dS0A9SzDiAs9iu1iN1rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122478; c=relaxed/simple;
	bh=j+/Zbhj0397GlAf9bk3DyqOk9vEKL5gkdOt/LsMAde8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSUaG3DXdX0PymTJIqNnG0hcfftksyHeM/ajgZ4cFYo72zS3LL86tkVoLpXCoVBh6k4069NakvHe1xgveyo+UravsJKyYgE9f3jKR4w/cuhoIbiymGdFni6LOY1MYjQ10xhKp439ZwIli3lGYiHDjqadD+2gv/t+3LV0SvhwuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FFPNAGX2; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f534f2bzPz9try;
	Tue,  3 Feb 2026 13:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770122466; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4l/On+lWAzchFEgBSmXoS7YeE1TOQqgzeEWrMQnW2Y=;
	b=FFPNAGX2Uo3WReiKzzKaxCOf37V5dbQzhGYXhlexvgByxNEB/6XRWaPl0vN69rDfxMdn5y
	rYUT4++x9sXUe5wkMUZDoq9w+aRwZ8YzPS/DAxGImnJ3c2tmkt0lZmlfsUB29GnzqPW6hA
	fY1lqcVNFzRVN2KzNLJ9ryoYTJvS2Y/YHfd5YBJOLbn2bYeJY3wDp8Fw8+VTbILi2FEwaj
	7IOx6xc7g/B+FzrfBHjBCl9zI4U+M0EPtX3jZNsgC/LRjQuziQgOFA5rCS0OI1gRB9PkRV
	tiE9AiPzW7+aNGQzd+p28lkclYeoTOhZ7BpkHc5Hy54nvA1Q3ja/Arjvvs82hg==
Message-ID: <431b8803109624e05901d44c55772402f811cf02.camel@mailbox.org>
Subject: Re: [PATCH] dmaengine: amd: Replace deprecated PCI functions
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Basavaraj Natikar
	 <Basavaraj.Natikar@amd.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Feb 2026 13:41:04 +0100
In-Reply-To: <20260203123238.88598-2-phasta@kernel.org>
References: <20260203123238.88598-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: isihekc8f1bq53ox1jxyx4pwyi61ainj
X-MBO-RS-ID: 7b7a4ec72ab5981ddc5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-8692-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phasta@mailbox.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[phasta@kernel.org]
X-Rspamd-Queue-Id: 20CA7D9365
X-Rspamd-Action: no action

On Tue, 2026-02-03 at 13:32 +0100, Philipp Stanner wrote:
> ae4dma and ptdma make use of pcim_iomap_table(), a deprecated,
> problematic PCI function.
>=20
> Both drivers currently request all IORESOURCE_MEM BARs, and ioremap only
> a single bar.
>=20
> Replace the deprecated function while keeping the aforementioned
> behavior identical.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> If it's deemed unnecessary to do the region requests, we could further
> simplify the code.
>=20
> Compiled, not tested.
>=20
> P.
> ---
> =C2=A0drivers/dma/amd/ae4dma/ae4dma-pci.c | 17 +++++++++++------
> =C2=A0drivers/dma/amd/ptdma/ptdma-pci.c=C2=A0=C2=A0 | 27 ++++++++++++----=
-----------
> =C2=A02 files changed, 23 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma=
/ae4dma-pci.c
> index 2c63907db228..872011d4dd37 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> @@ -10,6 +10,8 @@
> =C2=A0
> =C2=A0#include "ae4dma.h"
> =C2=A0
> +#define DRIVER_NAME "ae4dma"
> +
> =C2=A0static int ae4_get_irqs(struct ae4_device *ae4)
> =C2=A0{
> =C2=A0	struct ae4_msix *ae4_msix =3D ae4->ae4_msix;
> @@ -75,9 +77,10 @@ static int ae4_pci_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
> =C2=A0{
> =C2=A0	struct device *dev =3D &pdev->dev;
> =C2=A0	struct ae4_device *ae4;
> +	unsigned long bar_mask
> =C2=A0	struct pt_device *pt;
> -	int bar_mask;
> =C2=A0	int ret =3D 0;
> +	int bar;
> =C2=A0
> =C2=A0	ae4 =3D devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
> =C2=A0	if (!ae4)
> @@ -92,15 +95,17 @@ static int ae4_pci_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
> =C2=A0		goto ae4_error;
> =C2=A0
> =C2=A0	bar_mask =3D pci_select_bars(pdev, IORESOURCE_MEM);
> -	ret =3D pcim_iomap_regions(pdev, bar_mask, "ae4dma");
> -	if (ret)
> -		goto ae4_error;
> +	for_each_set_bit(bar, &bar_mask, sizeof(bar_mask)) {
> +		ret =3D pcim_request_region(pdev, bar, DRIVER_NAME);
> +		if (ret)
> +			goto ae4_error;
> +	}
> =C2=A0
> =C2=A0	pt =3D &ae4->pt;
> =C2=A0	pt->dev =3D dev;
> =C2=A0	pt->ver =3D AE4_DMA_VERSION;
> =C2=A0
> -	pt->io_regs =3D pcim_iomap_table(pdev)[0];
> +	pt->io_regs =3D pcim_iomap(pdev, 0, 0);
> =C2=A0	if (!pt->io_regs) {
> =C2=A0		ret =3D -ENOMEM;
> =C2=A0		goto ae4_error;
> @@ -144,7 +149,7 @@ static const struct pci_device_id ae4_pci_table[] =3D=
 {
> =C2=A0MODULE_DEVICE_TABLE(pci, ae4_pci_table);
> =C2=A0
> =C2=A0static struct pci_driver ae4_pci_driver =3D {
> -	.name =3D "ae4dma",
> +	.name =3D DRIVER_NAME,
> =C2=A0	.id_table =3D ae4_pci_table,
> =C2=A0	.probe =3D ae4_pci_probe,
> =C2=A0	.remove =3D ae4_pci_remove,
> diff --git a/drivers/dma/amd/ptdma/ptdma-pci.c b/drivers/dma/amd/ptdma/pt=
dma-pci.c
> index 22739ff0c3c5..d1c1c14b9292 100644
> --- a/drivers/dma/amd/ptdma/ptdma-pci.c
> +++ b/drivers/dma/amd/ptdma/ptdma-pci.c
> @@ -23,6 +23,8 @@
> =C2=A0
> =C2=A0#include "ptdma.h"
> =C2=A0
> +#define DRIVER_NAME ptdma

Oh, please ignore that patch =E2=80=93 I hadn't checked the fix for this in
accidentally. Will provide v2=E2=80=A6


Sorry,
P.

> +
> =C2=A0struct pt_msix {
> =C2=A0	int msix_count;
> =C2=A0	struct msix_entry msix_entry;
> @@ -123,9 +125,9 @@ static int pt_pci_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
> =C2=A0	struct pt_device *pt;
> =C2=A0	struct pt_msix *pt_msix;
> =C2=A0	struct device *dev =3D &pdev->dev;
> -	void __iomem * const *iomap_table;
> -	int bar_mask;
> +	unsigned long bar_mask;
> =C2=A0	int ret =3D -ENOMEM;
> +	int bar;
> =C2=A0
> =C2=A0	pt =3D pt_alloc_struct(dev);
> =C2=A0	if (!pt)
> @@ -150,20 +152,15 @@ static int pt_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
> =C2=A0	}
> =C2=A0
> =C2=A0	bar_mask =3D pci_select_bars(pdev, IORESOURCE_MEM);
> -	ret =3D pcim_iomap_regions(pdev, bar_mask, "ptdma");
> -	if (ret) {
> -		dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
> -		goto e_err;
> +	for_each_set_bit(bar, &bar_mask, sizeof(bar_mask)) {
> +		ret =3D pcim_request_region(pdev, bar, DRIVER_NAME);
> +		if (ret) {
> +			dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
> +			goto e_err;
> +		}
> =C2=A0	}
> =C2=A0
> -	iomap_table =3D pcim_iomap_table(pdev);
> -	if (!iomap_table) {
> -		dev_err(dev, "pcim_iomap_table failed\n");
> -		ret =3D -ENOMEM;
> -		goto e_err;
> -	}
> -
> -	pt->io_regs =3D iomap_table[pt->dev_vdata->bar];
> +	pt->io_regs =3D pcim_iomap(pdev, pt->dev_vdata->bar, 0);
> =C2=A0	if (!pt->io_regs) {
> =C2=A0		dev_err(dev, "ioremap failed\n");
> =C2=A0		ret =3D -ENOMEM;
> @@ -230,7 +227,7 @@ static const struct pci_device_id pt_pci_table[] =3D =
{
> =C2=A0MODULE_DEVICE_TABLE(pci, pt_pci_table);
> =C2=A0
> =C2=A0static struct pci_driver pt_pci_driver =3D {
> -	.name =3D "ptdma",
> +	.name =3D DRIVER_NAME,
> =C2=A0	.id_table =3D pt_pci_table,
> =C2=A0	.probe =3D pt_pci_probe,
> =C2=A0	.remove =3D pt_pci_remove,


