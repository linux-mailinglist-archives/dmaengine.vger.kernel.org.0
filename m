Return-Path: <dmaengine+bounces-2353-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDFB9043BC
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A51C24ACD
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C68005C;
	Tue, 11 Jun 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk8FmGu2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF54D8BB;
	Tue, 11 Jun 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130719; cv=none; b=O0sJZQNPljv+5IkzfIg6SN9vnlZb+m95O/+qXxXjkmxMZdMsnSJyZJDEj/SqokHIuQ5rBeAcRb+19Ss4PopYMIRaCExF25SO6RuuQPhTrZXk1WpMnvTBJc2fyllAbojaXN5hTvGZp2g+C597/HJQLSP56IV7WUIn6SlO2nRJjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130719; c=relaxed/simple;
	bh=k/LX02xjY1QLx7XZ1cDklsyZMvVB8elbP70y/dBD3oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngnq6PdrOIE/J4HlP3wUEwY3lQusw0+YgHtdrAkZK7pYf+yyAZBbOQ6tSW1abwYAVd3DsKQNb5JyznUq5tffUE1QG1Gn6rL6QuXWMnZ5AM2fUhRJ/oLWH9qnCPDqeVCuxB0C3i9C0qSeps1zkyy/lVm8X/W0Z4gYdj6bTsizZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk8FmGu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1802C2BD10;
	Tue, 11 Jun 2024 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130718;
	bh=k/LX02xjY1QLx7XZ1cDklsyZMvVB8elbP70y/dBD3oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uk8FmGu25nd07HTP2i5rnnjV2v7lhDN4L2UNieaPTEssfiDNP9YJPq9772Z5xw5bW
	 v6iv/itgFC5VnxeFeIpMFIXdxGHsNALWMQ8+uQKn0lP092X49UqBJQASoB/vTyLcXk
	 B2+pW9SYEWQNVv30NtbkaWeYBi8Y6jDYl1GtN9hOPmTddvdrSjL12C9bohTvzbzrw1
	 AVs+FMXyOftC803X5VsBZyap4wT5DX+H6cGpzD/60sAhV5AYDxemblpz9H17NGqk8U
	 n8m5OWLi1SJOg7bVW0st0QD8+YjqLNrGawmOeEanjMZwHFXJZ7I6a7cXdLYlnsELpO
	 4HG35OB46DOzw==
Date: Wed, 12 Jun 2024 00:01:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: keguang.zhang@gmail.com
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v8 0/2] Add support for Loongson1 APB DMA
Message-ID: <ZmiYGos4MFJWd-bL@matsya>
References: <20240607-loongson1-dma-v8-0-f9992d257250@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-loongson1-dma-v8-0-f9992d257250@gmail.com>

On 07-06-24, 20:12, Keguang Zhang via B4 Relay wrote:
> Add the driver and dt-binding document for Loongson1 APB DMA.

I get build warnings with this. Please build with W=1 and C=1 and fix
all the errors and warnings reported and update

-- 
~Vinod

