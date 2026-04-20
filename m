Return-Path: <dmaengine+bounces-10041-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEVsHRne5Wk1owEAu9opvQ
	(envelope-from <dmaengine+bounces-10041-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:04:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB67427F94
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E6A7301738E
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3E72C11E8;
	Mon, 20 Apr 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/QwEFZ+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8363859F3
	for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672225; cv=pass; b=pi4xUfcpPalTgktONHe6zbe+tmXj8juYHbklk7rCVhv+ic4oeTjmzgm+VNnBqi9kS6ISogYuwrqdjJuIMmK/acQEygzcG1jz8hE7YBMV5t8y4DAZ1yGlDqQI1H5G0fuk3O1q8BuS4qQrU3b/ft0gjutGC3ug+81S+5mCh0pcpS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672225; c=relaxed/simple;
	bh=AD/zIredsgfsCEP34x/bsMTFCh61zgjzg7Qg546Klu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNaVBOn1v8Byv3Hr1IXeS0zon6MFvbAnAdRLVvHAXXiUWKNV1IhKbxs9VYG7RoqA/yzQOlw3t785ug4tXwjylIuXzXVMH4XoCBmekB7YUfe4raHc+Jnn8rjtCmggoh0V7pzGXTc7MCpfhulMCT/chNOgd98Tvj/kNgPr2T4la88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/QwEFZ+; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651d692e833so2587926d50.3
        for <dmaengine@vger.kernel.org>; Mon, 20 Apr 2026 01:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776672223; cv=none;
        d=google.com; s=arc-20240605;
        b=GLhp/mcU3EhRdvdEkWSOl7jRahxLy4nHPmSfkemoWPE2XhHU52VPAOJxmQVRkA174f
         dUYwwUvdXucpBfsi2BP8glbwO/KGv6M5wh20n2VOrVZRcz12eOL/Q6fAV18NSa8vE9mU
         ShV9rcigeOh/5eQeWgjBJfKBnco0z1T/iDh9ueyVBoUtOIrH5I7tdxlW/kSV+yX6S57d
         aVjute9542GawRtaI7qn91imN5vrFVR0t7ZhMgIOp1ZtoD1x6TxunyS9qyC2ljvFESBs
         Y3s0Q0xgMVzLU5UOJ09NQ7nEFSpd5eA7dgXtRpqYmwaCytNQCYvm1CO95q0DTp1zYfZD
         kySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7Jz2ERRg05YqEeoJdExY/vcuAIzubKoobp39X/QVPjg=;
        fh=9OZ/Hg0sXPc3suQjwbRgBk5YXipskGDK4g+PrzeSL1U=;
        b=Z0rT8/0fGwllYJWT8eVgaO0SYkupkH3Vk6YS6Ea/TCJRnbnjhknHyeGNmCZ5kjGtVB
         U9R6QKefNmjbxEbOvyQ7plil8vid8yVR1YwxaKq62Rp4GAsQGF5mXzT4GJ55DHSuTA6K
         bYlxvSPkrGFVuuJebT5STECT9MGVsJcR0K0aSSQnjEjbW1adT8x+mAu1kiSF9gTt8qAi
         MlbMfCjJQcZvImKuR0DvKUJ0aGCPac9ErQmmL/QL3ZPq7K1TcJ6n7TTaDkWOr9gXqx1R
         D6JTvDc/pEitWatTqUc4vocFpEMAml+Ll5TMBPhG96kI4JQjIyeP0CN3gdDwYdkd1OHS
         nmgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776672223; x=1777277023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jz2ERRg05YqEeoJdExY/vcuAIzubKoobp39X/QVPjg=;
        b=r/QwEFZ+BwVFPPFgHbrIZDGWD7d0bVY2+5Dv7S7dsYkUAdbhjBPYNnEWGZuxgYiHd5
         nmliqRfrLqb7KiUdt4jaF9dPGPy57Zxu+/Muc2y/dDMWVnRoEVHYpNcOPFi5rIw1oe/U
         NnZtW30I8F9sHJF3awT2vzlckc76+wl67wXcMJ83IVLvdEEbEbr5R8Z4/QQi4kL3j1Yp
         1hvkVgv1VZ2Bmr1DxLofyZ7fq0DVRDHfPO1Q9LPnmWufwux39FSP2TeGMxf8nTBtvOTb
         CgPWPb0ujfn0ftnQgFtdcE4FFuO1gOsHUDsAJvq/VuEaa/iIXLmAsdMRfhlb6J0o1Bz3
         p0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776672223; x=1777277023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jz2ERRg05YqEeoJdExY/vcuAIzubKoobp39X/QVPjg=;
        b=bF3VvhveTM8x9qTlYAFnnjEOq1Aj2xe/qAoTUWM+ur/y3xM/yk4JFEj0Piv0j7O7DX
         bR1GSnB+vZre9VPOjDV7YMkqKfI9/oO090sEm9AzLLTf1AuFcmnusHx+1XFbGnaOSy6o
         MhyPz7gSF/dZho1ufbD01vOlLlNSXCCt3ZMMocbsHdoyTKDI44HRul1Hyfcct8l0+7yZ
         lA5PQHTSt9rsAC9HUqRr6u/gSYBrNsy+7YhacFT63YE2au/DzLv7JC4nxI7CS1Xzfzwc
         DPhcVuilTHW9uC5itRl3M36K/j5wSTYGXhugn8snOKcifMBsHymCISFsTNTEDj7CBd3b
         LZ2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/4uWZD/UWSIhVjonvUj06NsEOsCy1oP8GlPp4Jhn2RtDP0mOIEM7EheSOUjKwu0Jk8xUFtM/JkDDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkB/U4FKTpmozcWNuxd0SQ78BYpZIj2Zep7mTbFdfZ+EWNxsK1
	i3JyXHnQYM8NVAdjgQ4tBBGyPU6rNVqQtrKlwklcK6aw9/+hsDGK+Ql2aczav7MDt3RqB+E+94c
	zjDmvaCHbicHeVuFDN5YpjgPO0WWiqfVdLtdCAG22yLt2
X-Gm-Gg: AeBDiet0eNCQfj5dxH82z02hVVdFO45yMEt4+GlN1gY8uSlv+RwCaLdFaJk4MCEU7HG
	ZkRBnYTYkQSyjMzAmg/lCzAEQ+sMoEXBRa3J5b0Y9kXff2p3OsO2GzwZ3N40VVhVwK6XiwUdc5s
	iYnDRFqPzM/D+9aL55V+4z+lv692CwA62W0+5S3Qlj2MSkowdnM8G1LtPykG1OggEY68XhfkUPh
	VPm3QBNrjThM0Z5euuguOau0cbq05za5HUM/OF9Iml+D15kFZrD+h6C0RDHJEyENJv2HTccO2ku
	6Pw5Tx92Nmp+IAbIcskU
X-Received: by 2002:a53:acd1:0:20b0:651:ba8b:a950 with SMTP id
 956f58d0204a3-65310b57b32mr9454238d50.60.1776672223017; Mon, 20 Apr 2026
 01:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413135857.2898676-1-lgs201920130244@gmail.com> <aeXGZIrLhqj5hWG8@lizhi-Precision-Tower-5810>
In-Reply-To: <aeXGZIrLhqj5hWG8@lizhi-Precision-Tower-5810>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 20 Apr 2026 16:03:31 +0800
X-Gm-Features: AQROBzBFBiIisj-4pxiJZjLbnFn4lEYzxGSarNfLzYx2Gna7inl4HfN8ws7HQ1c
Message-ID: <CANUHTR_ceCh7n0eQxrZ8a5s25w=Bi6qyhDX1m=ZGLouKCNoJuA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: Fix refcount leak in channel register error path
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10041-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DDB67427F94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Frank,
Thanks for reviewing.

On Mon, 20 Apr 2026 at 14:23, Frank Li <Frank.li@nxp.com> wrote:
>
>
> I think it is meanless, no one reproduce this. Provide tools link if open
> source. Or you descript how problem happen.
>
The issue was initially reported by a static analysis tool I am developing.
It is still under development and is not open source at this moment.

I also manually reviewed the code path. The problem happens because
device_register() is implemented as:

int device_register(struct device *dev)
{
device_initialize(dev);
return device_add(dev);
}

That means even if device_register() fails, it has already called
device_initialize() and initialized the device reference count to 1.

Also, the comment for device_register() explicitly says:

NOTE: _Never_ directly free @dev after calling this function, even
if it returned an error! Always use put_device() to give up the
reference initialized in this function instead.

In the current code, if device_register(&chan->dev->device) fails, the
error path falls through to:

kfree(chan->dev);

This bypasses the reference-count-based device release path and can lead to
a refcount leak.


> >   err_out_ida:
> >       ida_free(&device->chan_ida, chan->chan_id);
> > +     put_device(&chan->dev->device);
> > +     chan->dev = NULL;
> > +     goto err_free_local;
>
> avoid err path goto again
>
> >
Thanks for pointing this out. How about this:

err_out_ida:
  ida_free(&device->chan_ida, chan->chan_id);
+ put_device(&chan->dev->device);
+ chan->dev = NULL;
+ free_percpu(chan->local);
+ chan->local = NULL;
+ return rc;
+
 err_free_dev:
  kfree(chan->dev);
 err_free_local:
  free_percpu(chan->local);
  chan->local = NULL;
  return rc;

This way, put_device() is only used for the post-device_register()
failure path, while kfree(chan->dev) remains for the earlier failure
path, and the extra goto can be avoided as well.

Thanks,
Guangshuo

