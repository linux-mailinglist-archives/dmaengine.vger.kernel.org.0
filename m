Return-Path: <dmaengine+bounces-10477-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFkzMirDBmpdngIAu9opvQ
	(envelope-from <dmaengine+bounces-10477-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 08:54:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4321954A2B1
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 08:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1CAF301E98D
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914FC3C81B4;
	Fri, 15 May 2026 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+TQzzPR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7E37DACE;
	Fri, 15 May 2026 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828029; cv=none; b=BqTp/qkzecUnfOMZFlNSBLI51Z8hbs1m/8VoE1gnA8o7zN/3xXBE6SQh8QQrFIjfloxUB3notLknyA+pvgU/tt88d76lbnAtyL1yNeKYwt2B+fpIqV4XOY2kOGpEJ71CTOmSOOFV7ozOvtdSf6lNc85xFsErcnWFYZ+0M6s3syI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828029; c=relaxed/simple;
	bh=413824PRUQhEgJLz9gZFcEje9ZX1tetIaGxs475/nOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN/lfkmJ6sJComOHdpcUPFjQu8pyMAuMpBZ8h5mH6Y6kza5tNf8hLn0oqexV0nqLsfv3Hi3Xnm3bDJxIov3FZK1MxBeQwJrYEM/o3m8moqtCk97I4R9tTL1Btw0MQ6r1RQAd5tClfEhYkJMn0DJ09+l7ZuiVF9mEZbBLfkP0EGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+TQzzPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82019C2BCB8;
	Fri, 15 May 2026 06:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778828029;
	bh=413824PRUQhEgJLz9gZFcEje9ZX1tetIaGxs475/nOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+TQzzPRpQKrmP4o3acGUVgNz6cXfNraSxVSzHky41qFKqBWCK48IDgKlFmzRtj+N
	 wzdfoH+VhbzORsROdYOl5MyMIjLNu2cVbezRY3ydIsf1fbtREaNQVmeggdRUq/KahJ
	 aPvBfNO2wetsDa1EKF3jEgvQG7SP0ooQ6OpwH5QIHmETg5wt2eRHkfi45Mt2vmPXmK
	 qFhTM8AfJZZffvYydhwwIrmqvVdJkSkeZtlsBxGQfoCvowh9gFHdUSj7A88WvONj3q
	 /AxS64xIXcWgBcKEva40nhOekWRzZSlveYqsZTM0C0ZxU3xzpxNnlKvxpbb8hb+21m
	 B+eFzWliutKVA==
Date: Fri, 15 May 2026 08:53:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Harshal Dev <harshal.dev@oss.qualcomm.com>, Arun Neelakantam <aneelaka@qti.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: qcom,bam-dma: Document BAM
 v2.0.0 compatible
Message-ID: <20260515-prompt-determined-ape-943cdb@quoll>
References: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
 <20260514-knp_qce-v2-1-890e3372eef8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260514-knp_qce-v2-1-890e3372eef8@oss.qualcomm.com>
X-Rspamd-Queue-Id: 4321954A2B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10477-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:22:20AM +0530, Kuldeep Singh wrote:
> Document compatible string for bam v2.0.0 version found on kaanapali.
> BAM v2.0.0 differs from the earlier v1.7.X revision in terms of register
> layout and offsets, requiring a distinct compatible for correct hardware
> description.
>=20
> Also add a new example for BAM v2.0.0 to illustrate a more complete
> configuration than the existing v1.4 example. The new example covers
> 64-bit address and size cells, IOMMU bindings and execution
> environment=E2=80=93related properties required on newer platforms.
>=20
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

I am not going to repeat my comments.

Best regards,
Krzysztof


