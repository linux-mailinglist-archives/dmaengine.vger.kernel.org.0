Return-Path: <dmaengine+bounces-4683-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F05A5A59B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2911892787
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D22A1E102E;
	Mon, 10 Mar 2025 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttHr8cmG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53E1D5CDB;
	Mon, 10 Mar 2025 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640802; cv=none; b=WGgCOWcDxTHp1cUnTYsFTqo3Ri/nCDP+9rHUXn4CyhwK7emNmgNj8ISHBwI9EaDVCuE19py4MxiE+hlEf/akfDBJqK8N/DsZaacrlHVrvtz0Y/xEyfNIn8zlHX9IXheGuNLD57UClm0q4vaUNCIUjftoqqc8lYgzxjttrvIKVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640802; c=relaxed/simple;
	bh=oezQm/NlqvpkxgAhyp0aHWDGb6ijzzY4BmowWL/8DaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DIKV2xcyCmnP/YUMhkquy7qhtW9Qo+FpGZP/m++AnreFWIniLIQmQhPUaAbAdeYo2u7wUuZ1lHZqLUWrgfKb9OqIIos+njewywXk13N4Kj/puXwLJ7o9DpHqxlCsLc0lXiK+QnvH0HUjKsbiputxpHNCy8ZReh+fB6hzIt1KhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttHr8cmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF394C4CEEA;
	Mon, 10 Mar 2025 21:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640801;
	bh=oezQm/NlqvpkxgAhyp0aHWDGb6ijzzY4BmowWL/8DaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ttHr8cmGF+ms+kff7kQnZn/6JCpkF13AQHNSOSeG9UYG4mK3/v0Cl78/UoD8OlcSJ
	 qA1Xjx4yLlYtDLnraNTKL/cMYaAPPdwFxlEIS57IWGalz5MxDKmJPxq90WrTHLY/nY
	 3VV2/RgWOnFhVaklGQCk9rOajgztlz71l0EBRd2Td98CS6MQvZdkTHHizpcwEesm1Q
	 vOfcCnOi0n5k5BJidMr7UXB9Xnve3/dqgNwd26DCAX8AVJ/eXJah40mqIXl32CLPrO
	 +XHvjsDDllOkkROVTMSd4d+c4UwJtzzTnpYGPreq1Ez5XB2aFhNJ9l39lfTY2lKC1+
	 BlMjsaTTAPWyQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Crystal Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20250308-ppcyaml-dma-v4-1-20392ea81ec6@posteo.net>
References: <20250308-ppcyaml-dma-v4-1-20392ea81ec6@posteo.net>
Subject: Re: [PATCH v4] dt-bindings: dma: Convert fsl,elo*-dma to YAML
Message-Id: <174164079739.489187.17067218233592397100.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:37 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Sat, 08 Mar 2025 19:33:39 +0100, J. Neuschäfer wrote:
> The devicetree bindings for Freescale DMA engines have so far existed as
> a text file. This patch converts them to YAML, and specifies all the
> compatible strings currently in use in arch/powerpc/boot/dts.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: Convert fsl,elo*-dma to YAML
      commit: 1fe283e850d6659dc3ccc295c6a0b470dd461047

Best regards,
-- 
~Vinod



