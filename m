Return-Path: <dmaengine+bounces-9272-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJeqHG5xqWnH7AAAu9opvQ
	(envelope-from <dmaengine+bounces-9272-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 13:05:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758C211349
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84DE23071716
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4667839EF38;
	Thu,  5 Mar 2026 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAq1R3xx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403D39B4A9
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712001; cv=none; b=cw8YhzDR9u74ZPd2g71e9tLExPJSAEuv2jE06qaPL06tRbNXiOHpuXpfKWv9Fb0sIDvf/AUtfG1+6yobtFQTgxn1rgSd//gooUXV0yyrATiwZPOonOpP67fUXf3T8GIttWvZRwLgHA1j/wAn/qzF09CB21bQvfRQQkKcodHGS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712001; c=relaxed/simple;
	bh=JjDjRMzh2S/8YB/HCuTF4SumXBtbSBGAlMdISgp8C0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c40ayo2QfiO+TO0rtxBKtKTcoyQNLwzBMZ9DL4oru31M8PBffHDuf0dpvwA9huSvnG3k4JJ5mr6VMSg/5H2xvWAWufMUNQkWZlkxrh7Lojo52LcdC5zMtuGkj75LwcjycR3BnG1rXuAIYr2Q2WMh8qRMn6m+IQLrrzNk9zaCgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAq1R3xx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so90548475e9.2
        for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772711998; x=1773316798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCREg50bz8e+v9Ahd+19Jw+eYOKRxSn1rxNuRLV4cFo=;
        b=YAq1R3xxVSTOHOmBAwtBH6/y61jQ0vDIyps5+UMuERYYQHuwJUWle7przFQT5vVrFv
         3xoFtPx0YchAjcnpIKXsEhZyhdNJnJynfwRAuaXoV9Q20fYdsrTXVHAiR8XUDRBQonTY
         gJYtXbytwHhySW4i3gizDvN4E2kAUYYzLy4MvNGAUYLKytPbV9/LRXS/c5V6Xspdx0pn
         Y/RaDkXhCHvhjgtBqzV7uve5ZPj22y3uhpe9XEZIkWue8rFqOlvOE7BigeOh/CICYIBk
         +w7JVk0aHFoA1l1uu/62xalO8JgwvCtqHpcjkF0/8c1lv4QjEma1tSlvcn9q/QqYZXMl
         Ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711998; x=1773316798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCREg50bz8e+v9Ahd+19Jw+eYOKRxSn1rxNuRLV4cFo=;
        b=K7xRQkEb0TIesPJ5r3zHJqleFp0n7OZB5NVaqN5FR/6BgJItpynehcDTvQzTjnZTb1
         OYwnXK+vrJQU+r/Pc90IidSnUQwaAVwvKYMwk8lF120q8xM4b7kOigXDOUUOr6NgaFU6
         O4v+stQnIlloET6t/J0EaLY4fxZQqYsyKpoyGlOqJfL2HiPmHKfKfoV52HSSMuidvq3o
         gqNDmuu1xGqDEsH97iodSU+6H0t8K679pFHXzDnD5eSkZIxQwesTuspm/IuBbCXaWXqN
         Pc9z4BH/zTPZbqrRdAcywLzq+kyVBQmpOXtN5uuR9wJFAmHY7Ps2x4eqmNcGgop1zTfu
         1Wrw==
X-Forwarded-Encrypted: i=1; AJvYcCUotZ70M+lRWkCOhGeJwl/ouuYi5gLgCncah+ey0UdCLMprE6R7m5DqcTdRfcxsAJMvgqIZIGc1/Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6wsFppnHrtfwNSYC9Y/er+UMUhPXx3gCdJ3oTr7HEFxGUfLK
	mR27OUpCGpuNSn8vkdafl+12qR5+CgWyZo+Lgq8EB7FYm3y3mvd5paCR804S/cod0ts=
X-Gm-Gg: ATEYQzwCPtr2njk5KbYsXqPEPDpYPVkMtTOd2kSIWfmYBL6BBpm57Oz0/DxtHFOayAg
	77QMfEBkv4xo4prFlhudZdDiX4a6C8LfrfDC9XyHXOJuAv7m7+Otqv2Q9lbj0QOCqAnTGKV/Pp6
	eT2z/S8Re3Ddgx4GjbXNVPHs14qnOaGkV11/jrLn8VBFJdXfUCvuvgqh4a06A6PQei/bVn+PPjB
	2IgWUmbeM3mVSzA0XBHQS3nugWnXSyRph+lt0++xR44jxyjkIDJJeQt622pqIlqsNwOAe2EVAcM
	WCV3xhjl7+Y2ofuEyj0XvuDqrtyiFrqSVJK5vCqWFabkMRyzD96/KyNggfp+9CV/Dcj0V0eSD2v
	P0PcVtbq/qTm3wQQ+HEhjn4g+vDjipsNkWPxyhHMylKn4vG5wK9daUIyi/5faxx/DSzJo9tSYV4
	QgA7oBhGF0TbPHEK71595d2kWlO7h4
X-Received: by 2002:a05:600c:1d05:b0:485:17a7:b9cc with SMTP id 5b1f17b1804b1-48519888633mr100850055e9.18.1772711997970;
        Thu, 05 Mar 2026 03:59:57 -0800 (PST)
Received: from linaro.org ([77.64.146.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b8807a4esm29845684f8f.4.2026.03.05.03.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:59:57 -0800 (PST)
Date: Thu, 5 Mar 2026 12:59:47 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH RFC v11 00/12] crypto/dmaengine: qce: introduce BAM
 locking and use DMA for register I/O
Message-ID: <aalwMwN3qMlzrql5@linaro.org>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <scr5qvxa7f7k22pms4c6k5gwiky7lhssrw6qryfngexlek44g2@rayinnnwqgbt>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <scr5qvxa7f7k22pms4c6k5gwiky7lhssrw6qryfngexlek44g2@rayinnnwqgbt>
X-Rspamd-Queue-Id: 2758C211349
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9272-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephan.gerhold@linaro.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linaro.org:dkim,linaro.org:mid,codelinaro.org:url]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:13:56PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 02, 2026 at 04:57:13PM +0100, Bartosz Golaszewski wrote:
> > NOTE: Please note that even though this is version 11, I changed the
> > prefix to RFC as this is an entirely new approach resulting from
> > discussions under v9. I AM AWARE of the existing memory leaks in the
> > last patch of this series - I'm sending it because I want to first
> > discuss the approach and get a green light from Vinod as well as Mani
> > and Bjorn. Especially when it comes to communicating the address for the
> > dummy rights from the client to the BAM driver.
> > /NOTE
> > 
> > Currently the QCE crypto driver accesses the crypto engine registers
> > directly via CPU. Trust Zone may perform crypto operations simultaneously
> > resulting in a race condition. To remedy that, let's introduce support
> > for BAM locking/unlocking to the driver. The BAM driver will now wrap
> > any existing issued descriptor chains with additional descriptors
> > performing the locking when the client starts the transaction
> > (dmaengine_issue_pending()). The client wanting to profit from locking
> > needs to switch to performing register I/O over DMA and communicate the
> > address to which to perform the dummy writes via a call to
> > dmaengine_slave_config().
> > 
> 
> Thanks for moving the LOCK/UNLOCK bits out of client to the BAM driver. It looks
> neat now. I understand the limitation that for LOCK/UNLOCK, BAM needs to perform
> a dummy write to an address in the client register space. So in this case, you
> can also use the previous metadata approach to pass the scratchpad register to
> the BAM driver from clients. The BAM driver can use this register to perform
> LOCK/UNLOCK.
> 
> It may sound like I'm suggesting a part of your previous design, but it fits the
> design more cleanly IMO. The BAM performs LOCK/UNLOCK on its own, but it gets
> the scratchpad register address from the clients through the metadata once.
> 
> It is very unfortunate that the IP doesn't accept '0' address for LOCK/UNLOCK or
> some of them cannot append LOCK/UNLOCK to the actual CMD descriptors passed from
> the clients. These would've made the code/design even more cleaner.
> 

I was staring at the downstream drivers for QCE (qce50.c?) [1] for a bit
and my impression is that they manage to get along without dummy writes.
It's a big mess, but it looks like they always have some commands
(depending on the crypto operation) that they are sending anyway and
they just assign the LOCK/UNLOCK flag to the command descriptor of that.

It is similar for the second relevant user of the LOCK/UNLOCK flags, the
QPIC NAND driver (msm_qpic_nand.c in downstream [2], qcom_nandc.c in
mainline), it is assigned as part of the register programming sequence
instead of using a dummy write. In addition, the UNLOCK flag is
sometimes assigned to a READ command descriptor rather than a WRITE.

@Bartosz: Can we get by without doing any dummy writes?
If not, would a dummy read perhaps be less intrusive than a dummy write?

Thanks,
Stephan

[1]: https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/securemsm-kernel/-/blob/sec-kernel.lnx.14.16.r4-rel/crypto-qti/qce50.c
[2]: https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r46-rel/drivers/mtd/devices/msm_qpic_nand.c#L542-562

