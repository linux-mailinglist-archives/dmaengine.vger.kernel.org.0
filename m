Return-Path: <dmaengine+bounces-6432-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE4B50A21
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 03:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A87443FA5
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 01:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5541E1E16;
	Wed, 10 Sep 2025 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4/lJImw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37841487E9;
	Wed, 10 Sep 2025 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757466950; cv=none; b=IgapzV5/JIceHc36nPpcuXGhzyPOTHcm5IKSIOnV8n5yAf+EoXqqsUGng+Iw4aR7NQuUv4bgRFOYG2RNHYqzPY2bXifIoCacvVeWrmg2yFaJBkFmugMe5MCn2e3wUyWHA2GgwdS9KbmrW0VmiM6GxVQilacR0yO6Y3fe/g/+wXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757466950; c=relaxed/simple;
	bh=cxlh3AJ76sbpWmAnYRTyLTELgkVNAiDa1hROV3mBUWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jk71l30EkX9VVabmuo6AGVq/6eT2EUVa3iw60EMm1wT4KVImzOLjwYOU85BCapp0Beo4n9LnUtCc2nKNxOtfFQmNDM56jtdNQuU/IUf0K+208UZPOsXD6SMKHhMo86HBOyOZ+sp6U0wpkKCI91epsuTK9+H1aMz800xDhh3XDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4/lJImw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6C6C4CEF4;
	Wed, 10 Sep 2025 01:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757466949;
	bh=cxlh3AJ76sbpWmAnYRTyLTELgkVNAiDa1hROV3mBUWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u4/lJImwhptY4sOT6NZoJ7bqQ4r1Ni8t3xFkLQ8PRTKy4+1dlGVEaou9KHTDVbIDj
	 F8SjFUNFDgYpOhAg9e1moGt/eKSoAbaDo/GeiBXPx3EWyDTcb7GZ3jMfEkn60WMQMB
	 AGW8hDkoqyVVi2S0vBemcUkZSEidafBQibN1ffg4XI+UlZkq9Smm1J9Ce9MQHlGwOj
	 lMPEaF/3TEOTuKpIsqLjzNtyujkP3zW5AK/w9p9KhYE+7f3fJQDxtaUEaJVUTtYoc3
	 cTqbvSdYrv2h5bunigBwd4MZbcu7uGk5qUy/qVF1F6+F5uRn84h1zYPcQ0RB0dWFCz
	 kr1Y41UEIIk+w==
Date: Tue, 9 Sep 2025 18:15:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?5p2O5YWL5pav?= <conleylee@foxmail.com>
Cc: vkoul@kernel.org, davem@davemloft.net, wens@csie.org,
 mripard@kernel.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: sun4i-emac: free dma descriptor
Message-ID: <20250909181547.0782840f@kernel.org>
In-Reply-To: <tencent_0DDFF70B944AC1B7CE9AC20A22D8DA3C4609@qq.com>
References: <20250904072446.5563130d@kernel.org>
	<tencent_D434891410B0717BB0BDCB1434969E6EB50A@qq.com>
	<20250908132615.6a2507ed@kernel.org>
	<tencent_0DDFF70B944AC1B7CE9AC20A22D8DA3C4609@qq.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 14:36:42 +0800 =E6=9D=8E=E5=85=8B=E6=96=AF wrote:
> Thank you for the suggestion. I've reviewed the documentation, and
> setting the reuse flag while reusing descriptors might be a good
> optimization. I'll make the changes and run some tests. If everything
> works well, I'll submit a new patch.

To be clear if you're saying the driver is buggy and can crash right
now we need to fix it first and then optimize it later, as separate
commits. So that LTS kernels can backport the fix.

The questions I'm asking are because I don't understand whether the
upstream kernel is buggy and how exactly..

