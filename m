Return-Path: <dmaengine+bounces-8737-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPgtOXR+g2mHnwMAu9opvQ
	(envelope-from <dmaengine+bounces-8737-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:14:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A128EAE94
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B599304B22A
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC15347FFA;
	Wed,  4 Feb 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afKbTclh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB0340A46;
	Wed,  4 Feb 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225155; cv=none; b=g1o7s56xwqTs1lBXtjYuoNENub9slP0AFuRTX3dg5irtzMeF4MGfD1QkGpoiqABGVYVagvYWR8B3SQP447IlES/vkeDB3lZR9Z5NGi/l7lzjA1jIdyJ88dc55td/OBthge0Q0tv2q6nEAQ2sdxegifyAIeXm5fJkGeQnQbPXQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225155; c=relaxed/simple;
	bh=78nod0bpS+X1wsIloC1zq5e7XtIjx240tkk0+Y7zA8A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d7VdjdENEp2CI+jx2ueBj6M/+c0j6t05MXLURoymp1WUs0kLGq3QdsV9sE0UD9i3B/lcUAseOlYEn4y2jVzz9JfewAeCDp4/Hy1ewx67hsOimDPDGeQSiYOyKVXUjLti1b2omIOqyBJyNAbMiue5i2OfBmZSAK26BehksTTjyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afKbTclh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18495C4CEF7;
	Wed,  4 Feb 2026 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770225155;
	bh=78nod0bpS+X1wsIloC1zq5e7XtIjx240tkk0+Y7zA8A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=afKbTclhiV1E3eWIDCNNU4HEEQs4gyTS18lttuVnwQVVqAuRoWsdZJ3/uz/BRn6Qu
	 Lfa40s0hTIsMt/aSGobKesmgtKrXkWzvuWKiaUxRu9EempiQG7uFBzKkFmqcf+aeY+
	 6UnY3j0OldO1P263/pgyvbNcd3/FWSekOWMe68gl4n9ViXXejcnGsK9ja+bgANosY5
	 WIjxjQJD/QXQBtTyzm/4QxdxCTuNq29hSj7Cba6shu+G512q3/zxPyTqX8GjuKZexn
	 Ip9R2DJVIfxNBJ4SNZe+hm76sZ8lWiQ9Ey+3sccfRW9vok6QwUsbxkadbsDqZILqS4
	 MHeZQxMM7sUsw==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260130042039.1842939-1-Frank.Li@nxp.com>
References: <20260130042039.1842939-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: add Frank Li as reviewer
Message-Id: <177022515373.153503.5735983873582302736.b4-ty@kernel.org>
Date: Wed, 04 Feb 2026 22:42:33 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8737-lists,dmaengine=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6A128EAE94
X-Rspamd-Action: no action


On Thu, 29 Jan 2026 23:20:39 -0500, Frank Li wrote:
> Frank Li maintains the Freescale eDMA driver, has worked on DW eDMA
> improvements, and actively helps review DMA-related code.
> 
> 

Applied, thanks!

[1/1] dmaengine: add Frank Li as reviewer
      commit: ab736ed52e3409b58a4888715e4425b6e8ac444f

Best regards,
-- 
~Vinod



