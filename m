Return-Path: <dmaengine+bounces-11158-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lzzYL+xSIWrODQEAu9opvQ
	(envelope-from <dmaengine+bounces-11158-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 12:26:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B7C63F008
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 12:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QElofj1S;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11158-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11158-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB0D43022FFC
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D372392C56;
	Thu,  4 Jun 2026 10:24:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CF39184E;
	Thu,  4 Jun 2026 10:24:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568693; cv=none; b=X/tbvUqUY3h+Il5CdPHvpTShVqu1Nwd/c5cBHaRPQy0amd4XV1tEHfhDsPG9PuncqWqhkcajiQwwwq4rWjJUJuJfVJf3alwZCw7wxh76GtUzSAKBtrIzoV2x+P1PlAuQGVD3jDEqwmqI7MJ4UN9mnMC/2KZkWhkepVn/+COJm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568693; c=relaxed/simple;
	bh=DUNkrCkw0SJaQUP5viB0eyam3KH5SYzBZYBmSC/AUsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NREl9L4A0HcJF3bNGUoGuzmflTby/o1PEQ3uitg3IiID3MZO2XLozMqBc5sA1uqX5UKNtBCjYt8IkF9Y3fCLjGGvTn+fu7Y5YIgj3brHbGTLquQAsDA588ziWrLYQldORBFJSNmwyxsCQ5cIL4WE7/CGEbYkc49AGg4pd3eVxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QElofj1S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025381F00893;
	Thu,  4 Jun 2026 10:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780568691;
	bh=9T1aihntidZljr34HDw/hIULFopJrt+Z1joPKFnXEaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QElofj1SOIeab/SKpIaqUUxs6uDMPVQ5dljMNgVGOMkK7pHKbxcCQwiidDNnmvSpY
	 VT/4ll6IDM4WFhBK8Y7LERc8KH+4qIly6/g26qu1A5NUrK4EHuXRMkHGtKIjkgWLUh
	 swl4e9psPUsC5lYaQmyVRnu0LqtHEXIYYHXMcCvZftRU+2R1oPXKkNWzQEOlZ4eCCG
	 ub8OpTEVvcypJtV82bp5caktDtdoUaEVNOaVyGMizLboBntDu+5OJGXCB844W9uXDq
	 8ZLKzXAxp+ZgjjuDUYOQtC3PeDeio8NkKH22MOoE1C9VWxfSIe7DjdvWuq1CexsZfG
	 0pJVKXe8D4SYQ==
Date: Thu, 4 Jun 2026 15:54:48 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	brgl@kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v19 00/14] crypto/dmaengine: qce: introduce BAM locking
 and use DMA for register I/O
Message-ID: <aiFScCW_NEY3CsEf@vaman>
References: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
 <ah8G_ajPS1KhgPP_@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8G_ajPS1KhgPP_@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11158-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stephan.gerhold@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,amd.com,codeaurora.org,linaro.org,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61B7C63F008

On 02-06-26, 18:38, Stephan Gerhold wrote:
> On Tue, May 26, 2026 at 03:10:48PM +0200, Bartosz Golaszewski wrote:
> > I feel like I fell into the trap of trying to address pre-existing
> > issues reported by sashiko and in the process provoking more reports so
> > let this be the last iteration where I do this. Vinod can we get this
> > queued for v7.2 now and iron out any previously existing problems in
> > tree?
> 
> Thanks a lot for working on fixing all these issues!
> 
> I agree there is no point addressing all the "pre-existing issues"
> pointed out by Sashiko, but have you looked through the other comments
> for new issues pointed out for your patches?

I hope Bart and Qualcomm can fix these driver issues as well
> 
> Out of curiosity, I was looking a bit at the comments for [PATCH v19
> 06/14] dmaengine: qcom: bam_dma: add support for BAM locking [1]. There
> are 8 open comments there (Critical: 1, High: 6 and Medium: 1). From a
> quick look I would say most of these could be valid. The critical one
> about the usage of dma_cookie_assign() sounds a bit concerning to me, if
> it is true we would be basically breaking parts of the dmaengine API for
> consumers by inserting the lock descriptor in front of everything else.

Yes this seems to be a valid one. Attaching another descriptor for lock
does not sound right to me, as in this case causes descriptor to be
marked 'done' prematurely.

Honestly, I am not quite happy with the way lock is being handled here.
I would hope we can have some better suggestions. Adding a descriptor
for lock does not look right to me. We are adding odd hardware/firmware
behaviour on engine apis.

I had earlier suggested to lock always or lock only for hw/sw versions
supported inside the driver, that might be simplist solution without the
complexity added here

-- 
~Vinod

