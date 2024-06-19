Return-Path: <dmaengine+bounces-2422-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CEA90E9F5
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 13:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0111E28AEB8
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6F13D52E;
	Wed, 19 Jun 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pO8J+jiC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A88173C;
	Wed, 19 Jun 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797456; cv=none; b=TnxmUOatbXsZcWchSF/k/gDHiidPkZlbway1SHS5lyCTr6a42x+NX573mg2sMHu6QDXZNjMu000zMzW30fZe7Ac98/L19Xw5o/T8YpzvXX5vzh6zv7qTm6ez7TBE0aPlXYQOEm5O5ZFoJWq2CmNULq1znG2UX4VY0dryn5tY+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797456; c=relaxed/simple;
	bh=1w3e2oYWGIqXsEaywy5K0UM/APtQXpvyD45et56SETc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hTAxgWXJj2XzsfEC/SZSMFX1TtcehkCLpjoltu9tKc7unvv7HF0omGnlzFwG7ovzHGQ49NpLVfilTGqQiG6sW1I3+GvEtzcqp8YrV3MHrKvX6AfeydP/meiQmqPv3eqAFtMR7YQ6wgNQUM5ru3A1fByWsLedKVNKxd3sXkum9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pO8J+jiC; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718797414; x=1719402214; i=markus.elfring@web.de;
	bh=W11j9754uQINKz/cvRsmwsZTifDgTcbludks+HYDFlg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pO8J+jiCXwN+5H4vNiREjjvXpyPdZ8/7MQT6ekY/ML1coCAKdQ5C3PKp4l/inzkh
	 sDpJ1k9BCUMD59DpnE9XRTQ3x7th8/fGfK1axZGRBcjUjTVTf76rq2kf1H01ggId+
	 PDiPCxVhzD6inumFLZxfYTh49fI0Rvl2mTSEXUFemqzvT++SqtXOorHYfsNB5pHDh
	 QOmXA+El8NcJFWKwyxbWedV7lXsibZDD3j/ly6mPT6mRDaj/atgw2jD6aBNxLta2M
	 l2s0KZIduo08S39btfpS6RYbbt7MPTFDGsG//a80se429nWeZGlUJGBCad8vskP0m
	 OvHOy9iewAMaan1kXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB80-1sDtAe3ISs-0024N5; Wed, 19
 Jun 2024 13:43:34 +0200
Message-ID: <fc3045c5-d542-4a6c-906d-84f72e776e9c@web.de>
Date: Wed, 19 Jun 2024 13:43:33 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Cercueil <paul@crapouillou.net>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
References: <20240618100302.72886-4-paul@crapouillou.net>
Subject: Re: [PATCH v11 3/7] iio: core: Add new DMABUF interface
 infrastructure
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240618100302.72886-4-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s/ePRc1AsDn5MbvhxB041oEonOdKZIbmxXBL6PQCyC+dACVDoLP
 VJHdbSN/Zg3VQNXnRwO9W6VRtbQ1aTeST+rO0ofPVv51Y8FxJ2M14FGXadcALDKOguJ6bGg
 8FPja/Ra9tp3qe1rhAftXdBeIZhQT5/j38O2mVfYGEg56wlULJFQtMGPXKAIGHUtJvKma+y
 nvdtZC4jpxgZj4GDXvxLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i7lnAXEpwn8=;/6wHovhhjAf8pHKa+TH+pZCmDYn
 NwpRNFSWg6I6UWBIN9oXcXPNN+0TQpTdTaoxKL6lzcXekoTV337eOBnwL8p5DB7dCXCRN/ucD
 JaspBk4OgvM80DshT4yRB1n1CfDntQFMWpEg7lDQQ3OZy16gcWh2xy0rJYi8nD/4be0eyp9pd
 HS/l4SafQaAUhh3ax0fJg7PfArxXxFxzn9mYapAzL7qNFrk6w9S+2HKA6UMN1mR7Erh5+tBRH
 MqGWdC7URlXxfsoYVZVwOTgZVap6ROFwS4RLTIifxQg3mar3FLLfq+RhtvbWHrXusvlIjtI6C
 /roGVf5+bIcorP8XW456QHvDftKm4oDzFaOvpPv/JzQvU44aipe3LUGpfjeQRctzGdzGeeytp
 EL8I5nMKRKBLvLjlqZfROhpVzIjmJSulE8skQsIYaxOh+SyP2hdhEKaz1BhF/Hc999AqkpeEe
 bGl7/hJvX7mNJxardrIb6+l36ns+EyoKdFq7eySfdkK5YopdzFzLk9G4y4NGxRiR+wXNMek0J
 ikYn/2qaC411MG2LZKoFPp7YUjiemvCzwHR5Z9mjVd9fcFXEMMIxkckaPuivaDXtj6xrjaTML
 Wqjn9nDLdwN6Sq3ffQNnznDyvJdJ8caWa/YjAohNYhV41qB8+QrR9qT0TlIA2kmDf95nPwui+
 q5s5A7QTT1hm+bd4DgydzDIxlHaVkzaIwrilFGReAUK7Y96l+yWsXbotc0El7MvhoaETns26u
 W5HnAReuDs9KJ3zHuRwkBpW0z0JTHoo6iiOBqIzX42ezgtcSLc4yi79ZdveYZgwE1k9OF96Iz
 go5dqUBvvQgmHHJK9Pp9f2IDPGGEgKg5kF6qqHYax9SZEc9be0jRsuPwI8SzLGmv+C

=E2=80=A6
> +++ b/drivers/iio/industrialio-buffer.c
=E2=80=A6
> +static void iio_buffer_dmabuf_release(struct kref *ref)
> +{
=E2=80=A6
> +	dma_resv_lock(dmabuf->resv, NULL);
> +	dma_buf_unmap_attachment(attach, priv->sgt, priv->dir);
> +	dma_resv_unlock(dmabuf->resv);
=E2=80=A6

Under which circumstances will another lock guard become applicable?
https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.h#=
L179

Regards,
Markus

