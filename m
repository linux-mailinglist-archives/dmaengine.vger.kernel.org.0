Return-Path: <dmaengine+bounces-10085-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNNmGIeO6WkvdQIAu9opvQ
	(envelope-from <dmaengine+bounces-10085-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 05:14:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DDE44C7AB
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 05:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E448C30115A3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2120C00C;
	Thu, 23 Apr 2026 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDM+ziEE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188E3128B2
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776914051; cv=pass; b=m4OLzVYaik3UDKZVjfYl+VTVWO7sacYPELuQ9Mr19GfS2eUYqVp5ms08y6miUXeKTaLJGWhiZbgV3cquYXg6kEGykgPmnwSIJXI1hKb04GSmltxKjiHwJzRHvmCcDMDffJlKVYg3tJ3VFu/KRN3qOEsI7b0BuYwiqqW/TWan+xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776914051; c=relaxed/simple;
	bh=shudGTvVCzWOaBlrtpLXOI7LUGzeV4XSn+NNbmOFUmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEH+EXkJ1URbPIXyKsAsq9RsPI9VhyCiw1Cvv8Ue+rzVLdc/KS7nHPO0Fa489nT/WvmERyY536kA7YkjEhUUh0Eo2UzyG4g64sAaPPWJSrpFywVvtoftpIobxgAIcavBrDq6304HZu9GvJ5XfjhgTMgQiIH3rX13ueXUTRkhGaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDM+ziEE; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a7109f568so74402717b3.1
        for <dmaengine@vger.kernel.org>; Wed, 22 Apr 2026 20:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776914049; cv=none;
        d=google.com; s=arc-20240605;
        b=AbX0BiBqfFcF87+IiOZyKnmcWQjC/p+tuF0rxjCflRzWcOqe/ZnnP7jQtETpXSh6W7
         X0SqpubyMIQMzBLO3BNgN6cec0Lyu+/tOXm3i3sqRfMIRHR23GQVVWIIunhoGWO1Lljo
         ZOnZ1IlOnGds+V/zigVYPt96ab7GiTaIx+MwYW7GP15u66BgqskyI3YmdDcJi2+m2yr7
         tiGHuD/2g0wRVaCw3VXuTUGI09WAFGeO83FfI+OC1jho79UQG/ReuPsaTjhPlOU+Ag1j
         64dad/1tbbPHiGI34NUxOXwUBG4qOf6MW3UCegFolKWPLrdOuFgKu7fcY7wcWQ8ECia5
         59lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=shudGTvVCzWOaBlrtpLXOI7LUGzeV4XSn+NNbmOFUmo=;
        fh=OqokK46+wel5yl917mR0XEecbqr7nnUwQ6cjj7bi+J4=;
        b=aargmOrmFdFEIaUlHc1MKq/CmOBARFQTdsWAbPM9uKPUv1jmEe+miPKMuzfdc5e0BN
         2JWY5VtQmKl3nOChJP8BeV0V4H1Tr/8GNYPyj2mCE1ZRUjKInBXi0FtwXLSvHThu5NrW
         qOE9LAzfpRymQH2CBvPf0JehhbHiUAzJBD5Qnfjqxn1rAFvc/XbS0AdkbVGTrQDNNC4A
         mETbZF/xwJT5ZlJB0mj8WZedZwRHtxhffY9mHFOySnxjeEiwLstKlYerKdc/0B7URRDR
         SBa86lDAR2SaFKy/uBaRStPtstyU8l653BognfFQcB+zwjZ3pWR3Z5XVs1xxA7fB0kGC
         cZdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776914049; x=1777518849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shudGTvVCzWOaBlrtpLXOI7LUGzeV4XSn+NNbmOFUmo=;
        b=JDM+ziEEPNxxZRqTtmymOQxKyWfud3CVlWEshx0CilZMfKeO/48XvUVOJCvrDz8lT3
         uund3iHiOe0s7yxhmKYt2m/+C9dxnJxYkuXOwG+04odSgDjFFid2+eXMQ+xg9/tUQ5CQ
         1qsUl9i6pIh0NC7t1VjaNBAN6jmlFvp3jWpJzzwdTYIY8Llm5AXYjiZZE7x0iEAqz44N
         HjjLFdk36FI9rCI8O+16YWUKWLMVageLwz2jRRxZSKjw6AGuUq+22Q6lGCuRY5BoAPWO
         kTqAH8saZKxARiEitI0XHL/Y9KKfzUbTtBoDhmHi1Nj1qyp8rj3zAlAsFtA0cCnWFJYu
         y3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776914049; x=1777518849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shudGTvVCzWOaBlrtpLXOI7LUGzeV4XSn+NNbmOFUmo=;
        b=WtxNuXzir0HY3KP/P8Z2FzB4rsrVRzel0piOkb77jTO1EenSjs+ezixaUzxwIsoXmW
         JKfuoDAP1+d8SBb9PCKdOVNN9tY8JNAsvApIAaDv1p5XCd7VTHQi7+dh9mTQ8acyHZco
         7pPOY0IrYAXdEOFG70K7EkhyO7PWz840SCMpZFSN+M45v3ZYzmy28Ur4XMOK14MvFrsp
         4EOjI80JRmM7r57Yzs9sLyJ7vvtRYGBGY+5zw4UfS914C4wfEXNnfIGWir8GqH4+YsVg
         C568hLvGI1g3dTk18AqpGQzonxA7FC2YE7LNGg+BXMK79bTqnt065uKvQOL0SoPGPPmZ
         l/+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hMQ2eePO4m5TO/xJPOADuLJ1hwFPxZ4hkl+zMs8e9CfLC3/ksw7qCbyk1+z+Zb3gFKpSI/kpjanQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3DBXnL7InuRhNry0LtxYxcF3SZSnACLRrAQRPZLkIIlqsfPr
	OYcg4hkfQKZZuxzGfuv79/47X4lUGCVDb2k/mTseuGpjjaro5mL4k/bZ8xZNVDJ0Cw45AhgXIIN
	8xGgUIQ0AZyRvxXfit7q3aXasHwPltcpp/w5l072z7w==
X-Gm-Gg: AeBDieudXsbMHoSrV4NkquoXzWlpLdmEb+tYqOU/sy2N9RntbMPaPr1S26lyNDsZDoa
	ERt/nN7VygLQUbkLLYpdB1FyXD38TSRxiMmsv6ESZH2ywXK6Xy1HWQ3lHyFqBbSgKI58UU/cXI6
	GKeyCgx/r3u1uOC3+DbO8eGrLJA8gLCG9V9MrIZuENX42mmlnagZX7Haru7TEUxo/b5+rRTp8lo
	cYqbWhcrUNYPzl8yjVDr0esy8wq4Osalbvk+uxU7qRDKacuuu0jVA5+9EEB6hFmuhN2QjyNWMy/
	+s6QHr44lxJhfAuWTGOL
X-Received: by 2002:a05:690e:ed3:b0:650:3e1f:907c with SMTP id
 956f58d0204a3-6531059530emr16317023d50.0.1776914048967; Wed, 22 Apr 2026
 20:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413113113.2725940-1-lgs201920130244@gmail.com> <87340m3bi5.fsf@intel.com>
In-Reply-To: <87340m3bi5.fsf@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 23 Apr 2026 11:13:56 +0800
X-Gm-Features: AQROBzBcHjCWMDIKu4eKnHDHBqJWQ-q-pT5XmmSFEBvux7VpXdd8kUaCt7bwZFo
Message-ID: <CANUHTR_UiN8V6wWkb2d=9p2FpxH79Fvv-mXCG9217h-aeak6bQ@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: idxd: fix double free in idxd_alloc() error path
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10085-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B3DDE44C7AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinicius,

Thanks for reviewing.

On Thu, 23 Apr 2026 at 05:56, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> On the review of 'v1', you agreed to the comments I made, but they are
> neither reflected in the code nor in the series organization.
>

You're right =E2=80=94 my v2 did not incorporate the broader issues you poi=
nted out.

At the moment I don't have a good fix for the similar patterns in
idxd_clean_wqs(), idxd_clean_engines(), idxd_clean_groups(), and
idxd_free(). Do you have any suggestion on the preferred way to
restructure those cleanup paths?

Thanks,
Guangshuo

