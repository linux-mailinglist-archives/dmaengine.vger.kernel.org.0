Return-Path: <dmaengine+bounces-11308-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JkgcKoCyJmpKbQIAu9opvQ
	(envelope-from <dmaengine+bounces-11308-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:16:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E729656093
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 14:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KYj7Ptgh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11308-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11308-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02E60303B1BC
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7F83783CC;
	Mon,  8 Jun 2026 12:12:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03A377EC6;
	Mon,  8 Jun 2026 12:12:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920775; cv=none; b=Sial/+Z07FXefqY5oYi+DJG7K2xD5/aImETOF0Ed/F5UMwEimmLHzoX/SsDKXniK3rOLE4XHElQprNMcLKOI3dHyQB7wjKxnOxeghmwpMTlPZHxu/j5kqc07Q04RLE1r9PtZKrhQ4C9pHsmKq5+EAQlbDXNGuqKLApCHMIwV55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920775; c=relaxed/simple;
	bh=K7WPAieQskxq/oe3MvGGCkx2k20TkYoHaNaN/G/HTks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FoXslfj3o1QXI3F+yWlFoRshsCGSIgPDpgEs+aIUr1Jq2gmPw9RedjkyiXlZfs+bUPY1ULQfmO+N4kwJG9Lsh51prA7H3ooGdWWoz23/aF0fQi9bw0ji4ygjlnV2oBZoHW9T7sYM+FAIdoASWDwOzvFKyX14hhZAN1WgglX6870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYj7Ptgh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19091F00898;
	Mon,  8 Jun 2026 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920774;
	bh=SMezmykpoN+CrmmLe+OLzzXM5lkWYZupE6qiHDtf2GE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KYj7Ptgh2BsOvPRmv3Eb5x/YISRikp6hlKWaAvAdTagzqxP2QY1PSNW5ZHSU4XfZh
	 QiHHZzqpGaI/iyGZCBzzNuiMlaVFMTpTKs2rL/AcP2zZtZ7Wx++qR8XPXl0HfBxL/U
	 QbTIpqLidvM4MpqEhWScVQJ4j7mPPFeXExIu4V645V2ohk9FHNSxqA+KY7q0RfbaJb
	 cyk6okH7jILTZScBWtm46Hxx0u+EgflCyX1iHOGO4GPGjwPrX1lLTmpgMAE52eaKSD
	 4R0GibTbFoM4FY9CqPUSPfa1HkmtBtPa37e45qEiHjGliNilJnoGCp4rIX0jfmPG6C
	 4BiBbKMDxuTNg==
From: Vinod Koul <vkoul@kernel.org>
To: bhelgaas@google.com, mani@kernel.org, 
 Devendra K Verma <devendra.verma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, michal.simek@amd.com, Devendra.Verma@amd.com
In-Reply-To: <20260605112829.679697-1-devendra.verma@amd.com>
References: <20260605112829.679697-1-devendra.verma@amd.com>
Subject: Re: [PATCH v2] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Message-Id: <178092077126.96550.2213347281404197588.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:42:51 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11308-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:mani@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E729656093


On Fri, 05 Jun 2026 16:58:29 +0530, Devendra K Verma wrote:
> Add Device ID for AMD (Xilinx) CPM6 DMA IP. This IP enables
> 64 Read and 64 Write Channels.
> 
> Adding the relevant dw_edma_pcie_data to use 8 Read and 8 Write
> channels for initial commit.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
      commit: c4441b95ae8012a99c6fe22b4f56155e0ddbd042

Best regards,
-- 
~Vinod



