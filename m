Return-Path: <dmaengine+bounces-780-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E5D8362E5
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 13:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C828CD61
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E013B1AB;
	Mon, 22 Jan 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aVUkt6ik"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD73A1D6;
	Mon, 22 Jan 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925756; cv=none; b=dm+SevIE0aURJssPAXc0JDpGoyIOyoTMlTGbhHAm8Ee1d+l61fYRX/urOmmGJDbj64o30jtkburHzg63Dt0apCtgchjZ5F+qj16nvkis8F83Su+3skCO+fXoa2+fD/1Dgf4MMX2v6phJ2Wl87cPUmLUdEdSOOPpymf+VDzwpr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925756; c=relaxed/simple;
	bh=JlI6oJ4yUpkIyWemM/YYc6/lnR2MeUov9gvivfsE8fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPd5ziyYn2EDRpaO1njuxSNrvNdieG5xMFBGsmpdlz5T5LjNX0Ava8zNrW3obRHiyKQ0PyB2K3ho5Dy/evMl9yLc32x367uwLuOdan+rbx87p+QWIhTgTPF8Sqi6pkWVMgKVyRLY1N7qwUM8R4dbv9ReWhTPa5eNQFmWblxOOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aVUkt6ik; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705925737; x=1706530537; i=markus.elfring@web.de;
	bh=JlI6oJ4yUpkIyWemM/YYc6/lnR2MeUov9gvivfsE8fI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=aVUkt6ik4gUZeuYOBMXqAs+0YCD5aH6EVw3mslrH0x+3tvJ/PsyrAQT5+8upnshQ
	 hJb2cp4LnCXrGBVTdzT+f0FnpsEoY2jrSIGL7Qu/nTSDIRFZtK0yz7Rj3kGjtA1kK
	 +SGHis0SoZ2Z29UkTwJlmpi2nGDXXzUwpBhgB4oa6RHICpMmVFAVLhhVNBQpEdPWu
	 AGSX5s7H8LuJkRtPO5uU6qylB5VOUCi5acGpWI5/ZRMxVrfsbg41D0wfzfz/ozdK9
	 yhRepbikmU+7JQXN0ovoV+g+uNkyOCzzfe9YYWMwD7aoAT6VnoKZO2guKD4/ZI2Fw
	 S5dAuqUMrO7OHqiHYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1rWGvw3I3c-004hJE; Mon, 22
 Jan 2024 13:15:36 +0100
Message-ID: <32eef8de-1e95-4e4e-85c5-9cc881b75bdf@web.de>
Date: Mon, 22 Jan 2024 13:15:36 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/3] dmaengine: timb_dma: Adjustments for td_alloc_init_desc()
Content-Language: en-GB
To: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
 <Za5SW6xdsOFylD7x@matsya>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Za5SW6xdsOFylD7x@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mn5UYh7mrmxQ0WaeWCTZLO++m6xX+ndy1U4RL6USooOPRiI2s3o
 YAFhZ1lMh/Qr9xsuSmfYRicdlojXl5ltelqkAnJmXeWKXZBDEV9gFE+HwQtcbBZ5pT29fQM
 SJPixYJXtJYtcJ9MhHqq+d1yx7VuzH9oG2hyLP3iEeCmDmfiOa5GaTD0dzp+STV3Z+N23xT
 u3kvQ6TBLC4klc35uhnmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:efwrYv3DkmE=;f9/ozwvaAeYDo6XGikObS3hiJJp
 u6URE5Ns/fSKfVfLK2QcKl5c9cLYzynW1zScAJya4QcuLVCwNNCoXjcYQO3fvCWJltKn9ETbV
 IS09zzdZY6wEFxUV1JL/d+H9XPXb0d/cGTAB8Ck3M3uilqqVJkmHDkdmwpJ6lwD1OCFMzDLfw
 m48WsZ6y4gzaR2EbhkI1qrLGQWYl8KSsDETSXfK2N5sQ6cgi2pmDHviC3f8KTVwPpAy9VrZ+g
 bzTgZ7aFvAuHpKq9NMprZoFqhAEcbeZE6OnTnOaL/t8ahW3wtHI8e6rTXCyUfW5aS3DuYKc3L
 uW3EQY/STQbHbHCV2/8AL3xmxkU3iPm/vWEFCB+w1aPN+BNlMGNm6P5VUnyBRNm4reFwfTfuw
 tLRtRnRBHRPyr7UXOziQknJ+e/6z1ivhk9MHM+KHMvROll09H/idbW3Qk2W1AkiTtqDIHqVxo
 h0HqGhtUelAA4Cm7x/RlPLe8W+TLWff0vffJEEVH7vPDRw/EIgOW3r6eGwxCvZOfglugyh1dN
 gThzTkXHP4trMhr3g4Olj/BuArvGAwlQuiV5bJmgDYUGGFodVVglg/xO8hwzI4CRPQpWt3uz2
 aiGhX5Uf/mnr5RG0OBMmuPo/PUEdt1WDBP+Diocv3q8oC+WNtwawwqoNK0XGwEdJ/FKJp1qbG
 OAjRmLwLYEULjhOMK1b0HezRLNio3NcB7NaaOBI047y+P/A/auGw3qWoQnGAjktdE1/61a39l
 eONsPqv4kfzzI5OKPbF1/mJylHz1AqYMUbdzRncSMA7gRwWjAcH9U+s1XnBFkbUm5KqR5RYaj
 tRMkkBsWGRLG2YkbHovTK9mda3vaYBAWUrwczM0rjJi/nlvX9Ak+F88ONR2P1jU7ojugh+8lf
 DJzR0u/0xbaYHrLgCROMtt2+VJqc3WGAnKxdIB5FbhUnXyqK6r1VXkCYXeIn5c+Ug7buMkN1H
 8WEBkg==

>> A few update suggestions were taken into account
>> from static source code analysis.
>
> was this anaysis done by you

Mostly, yes.


> or some tool reported this.

Some scripts for the semantic patch language (Coccinelle software) can hel=
p
to point places out for desirable source code transformations.


> Frabkly I dont see much value in these patches,

It is a pity that you view the presented update steps in this direction.


> can you fix something real please

You might occasionally find adjustments from my patch selection more worth=
while.

Regards,
Markus

