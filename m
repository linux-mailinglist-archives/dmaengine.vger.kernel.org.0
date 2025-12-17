Return-Path: <dmaengine+bounces-7745-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3432CC72FC
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A19E33022F88
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58633B6DA;
	Wed, 17 Dec 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD0aOBwj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032A325709;
	Wed, 17 Dec 2025 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968339; cv=none; b=YvkkP4VY+n1Vq/YCR3/w9+jqF44YdJqyhSlo4S4ThPXdDZIS38+9pZC9kngCuI0RHdO7ZM2mOpBoui/mkrzJRQ7X4lRNSnTAtDy+dbkfP/EWAH2O2vZ2DzVO90yqDnVkrM2deRC0KmV1eFFk09P0DmTky80R5DcsaZxTeNshemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968339; c=relaxed/simple;
	bh=AVUg2eXMFGByY023i/MJH+I7Cv8+X+oAHX7+mxdIRIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oemKZM1+w4/nFCpOSJ0iLOpBXJwKDPKTccKwaFJu51/Zo1GD0he9U30rkn1UfWkU1j4bdCnsrj77pBPmSMBLcwIH6q9jetr3LxEPsfWYdhAaMGd4tRdCpU9taJ6LDk7rY0R/Sge6szgZh/N5TODnb+PpI0qBjuOV2qXnDr/1DIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD0aOBwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03876C4CEF5;
	Wed, 17 Dec 2025 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765968338;
	bh=AVUg2eXMFGByY023i/MJH+I7Cv8+X+oAHX7+mxdIRIk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RD0aOBwjc4u+WzSxiaX087/ZGGqPi7278kJoholQUd26OQ49RxRCW4TYz/VxYkNh8
	 yQSeutOlpwdq+RSMPa+aa5I5OYMYygUxG6YC/ltzfdj8Bfc3kCfkPP2v9mCVtH8QhG
	 dPTKCxI7vP3uUnVpgzCAqShcaa7pg9tibuK+kB9uDoHslvpnItbiSq0cK72dyKYP1/
	 3zqywWp26+d/Yz7ZKE4tgNuzlC3hbKToDLxTXyWLdTeObgmzCJG78Vw8wr0zRH+QZi
	 sqazQyNQdwwOKTCtO09l8egMnmg/jaSZ25S7kiIBJtZQihHSBGl9UWZbI4he9U/CH8
	 flLTz2vFrTrlQ==
Message-ID: <6475226a-0291-485b-af93-054ed3cfe664@kernel.org>
Date: Wed, 17 Dec 2025 04:45:35 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add dma-coherent property
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul
 <vkoul@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
 <e1aae851-4031-4b5c-a807-7a61ecfe6af1@kernel.org>
 <877bumsv3q.fsf@bootlin.com>
 <f1948d54-2e27-44ca-8509-ca16f9b792fd@kernel.org>
 <871pktscld.fsf@bootlin.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <871pktscld.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/25 03:05, Miquel Raynal wrote:
> Hello Dinh,
> 
>>>> Applied!
>>> Have you applied all 3 patches? If yes, where? It happened during the
>>> merge window but I see nothing in v6.19-rc1. I was about to take the mtd
>>> binding patch, but if you took it already that's fine, I'll mark this
>>> series as already applied.
>>>
>>
>> Yes, I took all 3 and staging it in my tree for v6.20.
> 
> Noted. If you happen to rebase your own tree you can add my
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 

I'll do that.

Thanks,
Dinh

