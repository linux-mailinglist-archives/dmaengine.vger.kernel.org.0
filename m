Return-Path: <dmaengine+bounces-3888-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828419E3B22
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD4F1690A6
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0041EC01B;
	Wed,  4 Dec 2024 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od8C+3OJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770F1CDA14;
	Wed,  4 Dec 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318348; cv=none; b=nUXCHKdaLoz2olGMqNgEosuhqaVKILH/oZ2LbSNPc5KJ9V9HlRW4DL4lI8ZUWOrh1MkWzjic7FGcOfPLMnuxwfVveTd8KxXpnRUnuN1yopKM5tDzij4V5Re9tDh6prOGaMYA1/rOUCe0qOAtArfTgGt0XqB/pS0LJLNH6ZNk6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318348; c=relaxed/simple;
	bh=ZpMI8hVb0U1HHafbH1J2thkdRks+nHMgu2u0L/xQeXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RN0PnmObXXlUonK1p1EAsbsQCqeBt5WHc3/x8z3pFSF/++0/Q9EBJ3SbB+rKRJcUfwn7UtDQhfJGipUQuO61nn2foSc52sLgp2VvEnt9gSbGHmNqy5SKX+Snw6USavSENDGtJ6rYmC7Z7QFXj1iKGpBTtbMGppfr1WsZD/AROZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od8C+3OJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139B0C4CED2;
	Wed,  4 Dec 2024 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318347;
	bh=ZpMI8hVb0U1HHafbH1J2thkdRks+nHMgu2u0L/xQeXE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Od8C+3OJ/q2h+2yOMJRvZzbxKwl+kL/cpf/69hrXwpDokS7M1CZBYYsWeYGnmgl/A
	 ALh7XrQw2IABDlGNSXotw7+bxW9uZsWA2dR+niaIdhXQ2L6NrXovAKka6Xb8bxSmf1
	 79Z8VvYR/bcuDxkMrzacGTpwDXyyQnDr0N4+vCgeK8/u/EnK5kvzPy/bQjVbicpFpf
	 MEdNNv4hLTNJiRWnk/kM5kWPsz+EkmDqs412G4x3Bjk2O7rRe7Bo5NCoBhMpowOjx2
	 yd6wSvfYnwVsDfT35NVqTG5F6Uvi2Ih1rmXYJzkspdH9Wmz2P61lAeqrZWRT9nBeT1
	 YoiEn4mQifJZw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Trilok Soni <quic_tsoni@quicinc.com>, 
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
 Melody Olvera <quic_molvera@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241021230500.2632527-1-quic_molvera@quicinc.com>
References: <20241021230500.2632527-1-quic_molvera@quicinc.com>
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Document the sm8750 GPI
 DMA engine
Message-Id: <173331834470.673424.634326123005438130.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 18:49:04 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 21 Oct 2024 16:05:00 -0700, Melody Olvera wrote:
> Document the GPI DMA engine on the sm8750 platform.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: qcom,gpi: Document the sm8750 GPI DMA engine
      commit: 9584fc5efd507c569aafc7bf0beaa15c8eb07a8a

Best regards,
-- 
~Vinod



