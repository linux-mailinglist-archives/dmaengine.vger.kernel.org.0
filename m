Return-Path: <dmaengine+bounces-9355-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M+PL4z/rmkLLgIAu9opvQ
	(envelope-from <dmaengine+bounces-9355-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 18:12:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815B23D72B
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 18:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8EA5303B7F1
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 17:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA1377541;
	Mon,  9 Mar 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geuaaSQv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06F3B52F4
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075962; cv=none; b=QsNeEOyZntsvJwXTJQ6NzFiKGuA7whYoNQHlC3z2VHvavxRc0tE4sY7QyVnrU/v7QIBz5rfCrg2LqvYYMib4yNDXpyZv0OgAR706YqgEzBVoIWdwXwmUQFfwDFJ3Hf3iy7LwnFtQAk72KelufE4ZvEKpzeMEjBQjVq3OzrlWKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075962; c=relaxed/simple;
	bh=Nl4HOblw010V5+pE2S/P/QX3P3lziK39Je/lLiEZbvE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gp5YTeeIfC3LmEwIhjs57KGejcvk7bIMYg9ODnPvn21P0YX3oEdB+lMJdkGABXWn/q6RANIQvhd/rLwvNIX09KMa94sjT2blaEklUykR6uxyMIR68XhbaSI++FE+a3PoYffe3erubxBopxdAKZYWZrXiWio3uJPzmuuMTj8Ud4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geuaaSQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CE8C2BCB1
	for <dmaengine@vger.kernel.org>; Mon,  9 Mar 2026 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773075962;
	bh=Nl4HOblw010V5+pE2S/P/QX3P3lziK39Je/lLiEZbvE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=geuaaSQvhOJNX357Z9w1wt3tQulaQ2XrNbaryqjHB41cQrIEKqI/vZq5TaPrTTZU+
	 M9vyJ9dq4ijyvChbTm7rBXIN+xqp7/7Zg+LweUoaGQQCyIzdQIbX7vO9RmCBO6SNh0
	 HCkM2f6NvmQE+cjtgjISXrFdntTFS+KmP8R7IFEr9MshUvtq11+rZDb9ytOF4jZPhy
	 KjfxZqgFqENm7BRNZg+fcqG3/PRG0xYL6KOoxcXbrxqFB9eNIaHOcjgrNo6H5NQrFp
	 r+IQpXqjhjyxflvNd5G53edsKI7lnL8xnAnY+13IpRtz43P5qHajtmAGju844wD7nb
	 WMU6swPIGVMOA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a38ccc217so32464631fa.0
        for <dmaengine@vger.kernel.org>; Mon, 09 Mar 2026 10:06:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfuYQTyhddAFs0MCFZac1dmfmSLoq6ZyZ8CK5LEq4L+qmDstv1tU9EZXvhxUXuh9VbKXwX+UOnZOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxjuIPcw2nrpJ9y0YvP9Di5K0hundMJFvJtRjVZsqWqC8SCVI
	zgdWXRfH2YZ0CXGrdjdW8lAhChPZVrn+m178YpDfQCdBFrLt0nL0Rz1Fd4I/HLR7gSZvPIiiAe9
	1OWRuQ+AvAjhpgRm+2yip03KKyTM1YXVqpDWmJy+KpQ==
X-Received: by 2002:a05:651c:2212:b0:38a:42ec:9f84 with SMTP id
 38308e7fff4ca-38a42ec9ffcmr33518861fa.4.1773075960460; Mon, 09 Mar 2026
 10:06:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 10:05:59 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 10:05:59 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aayLkmDRLMuTzXZv@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <20260302-qcom-qce-cmd-descr-v11-12-4bf1f5db4802@oss.qualcomm.com>
 <aahHeR9j7q4_ynYK@vaman> <CAMRc=Mc48+NyMPkFRa8GPv-odCe=r9WXJWUZYkTsaY53Ev_stQ@mail.gmail.com>
 <aayLkmDRLMuTzXZv@vaman>
Date: Mon, 9 Mar 2026 10:05:59 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeJNQq8AF9SrJYY=CNOF62UXpaX7Tzuk5VSfaXoWSCGRg@mail.gmail.com>
X-Gm-Features: AaiRm52AwUikzvApltwtSp3ZuI8KyckqNAj_xcMnQHdUmblkYlZhjv-tlMSJcGs
Message-ID: <CAMRc=MeJNQq8AF9SrJYY=CNOF62UXpaX7Tzuk5VSfaXoWSCGRg@mail.gmail.com>
Subject: Re: [PATCH RFC v11 12/12] dmaengine: qcom: bam_dma: add support for
 BAM locking
To: Vinod Koul <vkoul@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6815B23D72B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9355-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,amd.com,vger.kernel.org,lists.infradead.org,linaro.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Sat, 7 Mar 2026 21:33:22 +0100, Vinod Koul <vkoul@kernel.org> said:
> On 04-03-26, 16:27, Bartosz Golaszewski wrote:
>> On Wed, Mar 4, 2026 at 3:53=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wro=
te:
>> >
>> > On 02-03-26, 16:57, Bartosz Golaszewski wrote:
>> > > Add support for BAM pipe locking. To that end: when starting the DMA=
 on
>> > > an RX channel - wrap the already issued descriptors with additional
>> > > command descriptors performing dummy writes to the base register
>> > > supplied by the client via dmaengine_slave_config() (if any) alongsi=
de
>> > > the lock/unlock HW flags.
>> > >
>> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
.com>
>>
>> [snip]
>>
>> > > +static struct bam_async_desc *
>> > > +bam_make_lock_desc(struct bam_chan *bchan, struct scatterlist *sg,
>> > > +                struct bam_cmd_element *ce, unsigned int flag)
>> > > +{
>> > > +     struct dma_chan *chan =3D &bchan->vc.chan;
>> > > +     struct bam_async_desc *async_desc;
>> > > +     struct bam_desc_hw *desc;
>> > > +     struct virt_dma_desc *vd;
>> > > +     struct virt_dma_chan *vc;
>> > > +     unsigned int mapped;
>> > > +     dma_cookie_t cookie;
>> > > +     int ret;
>> > > +
>> > > +     async_desc =3D kzalloc_flex(*async_desc, desc, 1, GFP_NOWAIT);
>> > > +     if (!async_desc) {
>> > > +             dev_err(bchan->bdev->dev, "failed to allocate the BAM =
lock descriptor\n");
>> > > +             return NULL;
>> > > +     }
>> > > +
>> > > +     async_desc->num_desc =3D 1;
>> > > +     async_desc->curr_desc =3D async_desc->desc;
>> > > +     async_desc->dir =3D DMA_MEM_TO_DEV;
>> > > +
>> > > +     desc =3D async_desc->desc;
>> > > +
>> > > +     bam_prep_ce_le32(ce, bchan->slave.dst_addr, BAM_WRITE_COMMAND,=
 0);
>> > > +     sg_set_buf(sg, ce, sizeof(*ce));
>> > > +
>> > > +     mapped =3D dma_map_sg_attrs(chan->slave, sg, 1, DMA_TO_DEVICE,=
 DMA_PREP_CMD);
>> > > +     if (!mapped) {
>> > > +             kfree(async_desc);
>> > > +             return NULL;
>> > > +     }
>> > > +
>> > > +     desc->flags |=3D cpu_to_le16(DESC_FLAG_CMD | flag);
>> > > +     desc->addr =3D sg_dma_address(sg);
>> > > +     desc->size =3D sizeof(struct bam_cmd_element);
>> > > +
>> > > +     vc =3D &bchan->vc;
>> > > +     vd =3D &async_desc->vd;
>> > > +
>> > > +     dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
>> > > +     vd->tx.flags =3D DMA_PREP_CMD;
>> > > +     vd->tx.desc_free =3D vchan_tx_desc_free;
>> > > +     vd->tx_result.result =3D DMA_TRANS_NOERROR;
>> > > +     vd->tx_result.residue =3D 0;
>> > > +
>> > > +     cookie =3D dma_cookie_assign(&vd->tx);
>> > > +     ret =3D dma_submit_error(cookie);
>> >
>> > I am not sure I understand this.
>> >
>> > At start you add a descriptor in the queue, ideally which should be
>> > queued after the existing descriptors are completed!
>> >
>> > Also I thought you want to append Pipe cmd to descriptors, why not do
>> > this while preparing the descriptors and add the pipe cmd and start an=
d
>> > end of the sequence when you prepare... This was you dont need to crea=
te
>> > a cookie like this
>> >
>>
>> Client (in this case - crypto engine) can call
>> dmaengine_prep_slave_sg() multiple times adding several logical
>> descriptors which themselves can have several hardware descriptors. We
>> want to lock the channel before issuing the first queued descriptor
>> (for crypto: typically data descriptor) and unlock it once the final
>> descriptor is processed (typically command descriptor). To that end:
>> we insert the dummy command descriptor with the lock flag at the head
>> of the queue and the one with the unlock flag at the tail - "wrapping"
>> the existing queue with lock/unlock operations.
>
> Why not do this per prep call submitted to the engine. It would be
> simpler to just add lock and unlock to the start and end of transaction.
>

Becuase then we'd have:

  [LOCK] [DATA] [UNLOCK] [LOCK] [CMD] [UNLOCK]

while what we want is:

  [LOCK] [DATA] [CMD] [UNLOCK]

Bartosz

