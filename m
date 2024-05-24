Return-Path: <dmaengine+bounces-2152-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85628CE517
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 14:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764581F21E26
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1883A19;
	Fri, 24 May 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KD0bA4JL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55318061F;
	Fri, 24 May 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552986; cv=none; b=G8efN2nMRfYWjztRBlD32rM+k5VRDrzl6r4N33vs85YddUx50bqfAdkFwRaSOGQvxwQm49vjbt4gFCLk59OWqYwzyRE6yDGJ5Ak2B+SHdQfvtFMB0xxIEQdz0wO5yMFPUoGGR0A1FFV+8twxP37vJV2hgVFwG3CWMxVxuLczvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552986; c=relaxed/simple;
	bh=783e2VG1vsU3Plu/mHMYKOLDlL3eD29yilL+kq6F6Oc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=h8R/BeXaDg11a1DHrRNHe68d0cHcZKsoHGSwueICXJi3bo/FDGIl+CXTGBz10B5KBp8rWs8A1j04D/C8kU9oHS9xM9YuFS6rOCSUALsXlorp9AU7PFdmyEz76yT95a292BisEVXrT4Po9LbCv+X4pH3PG6xq00Ax3x6xisMs1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KD0bA4JL; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716552937; x=1717157737; i=markus.elfring@web.de;
	bh=2oxL4haj3cSIhrDqG5f5FY2ZS3HnP0RlB6rXmHfev2o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KD0bA4JLFNk+jBdCvbBup59pAZL3DT9yJAeUc2GSSApob0ZclOT4ZArtj/DhNyV/
	 RpRBYj8cUFsuG2Xgbyl5rKNmBi0uAksmvDIYjRNmHpmjG70M5zHl8IgFkvfP0fZlm
	 50WBITuXU538syBr1L2HuNLxtUPoPeMAzldOZ/SZUJPiA99Hn8Cpu+qJa8n9vqTmz
	 gUD8m+wn5X0iNJ+EDubJ08g+qQfPr8Ja6/Co6m+pk33qX6guW3Oz0nAx1r6m47OTL
	 oI88SrMeMmG0rv5slMdsbYgXVMLkk3pCPvxLee4urFF+FCqpcC2APahEFRcip1NMb
	 aWaI94ZYgfERPApCNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3oz4-1saqL30mjw-00zrAk; Fri, 24
 May 2024 14:15:37 +0200
Message-ID: <48e4d18b-cef8-444e-8638-25b9c6fcaa40@web.de>
Date: Fri, 24 May 2024 14:15:31 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nikita Shubin <n.shubin@yadro.com>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20240524-ioatdma-fixes-v1-2-b785f1f7accc@yadro.com>
Subject: Re: [PATCH 2/3] dmaengine: ioatdma: Fix error path in
 ioat3_dma_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240524-ioatdma-fixes-v1-2-b785f1f7accc@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wOFWpGqF7uD0/ANGC5tGcR14IIBXwbZ56a74jK+DUz35Y6US6jw
 6fEIEtM+POWnEs6Rdx6h0dqm/aiBj9nbZn/IbGvYJ3ncHpwN+4lrKu5nuyUKuQAFUk/PhgM
 ZExpeQhfhepOdoS0R79+1ya3v/7OcZx377r/+f7xWvezyzK5JdzJPLJ+jdkxpgnAktb6Z3r
 gLgpCMIujpJ7yRAEv6xZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tOeCAp+CB1M=;0G/vCOWf6HajPQeOr0lRD0H5Fud
 55M65QpwSB2t6OiRrzrqtqsS9Km0nvjAZb6ih/mL0adSG2sa8spMung97IHXKhfC54KbhYNds
 wDN8El18ZA/3SDz0X8nezQuqmzZZBAAImdbPlowHmedaRTtI4Rz59ibkChsboaKcL4b1+k9oU
 7jDJsdvxNxLkTRYiL3fWmX0zijMZeAC89R+uX+a733qWCPpIo8drphYsRGTqIkRcQCJeE3+eB
 I5UHCrvc+b8GNh2P+Uo+w1eNNsWQUHAsTUHzpZyWv0a6vOzgUttuUHUV9PoDFQjGFXzRRQsGX
 1Xe0Wh0LGs66sGe917KXJwZLds21H6yQrlR6+SmSQ00DGb5qzBCoDh/yCBLYiFQCUZbUrg87w
 Wlupv+62TCXqGqGkx1EiubEtgpTtUkqIEactB7IsUeR/fx/bYBQSKslZNNXKpkz4ruj/b1Up1
 pFMbU2VDHbhakw3JBYR8bega2OVNxijYlQgWXP2XQj9AXllvjLf6M6kmixuTs+07ovydBIyC4
 4Q0+uChVyhLZVbOupu/CbJRtUKCb4A9pQwE67boFWSscRXTfdWOFaID9Ia1e8o0eR0OlNYmrQ
 Pi6AOesN73wtzxQUzKHf9U/FAVGtVlfKCPhVsYzc9Ztj6Ayr+6uDA+koJvGudS19ILlf7JfQr
 u31DzhkyLKFlC+JR/64HLP88M54VfPc3pMq3is+o28P2EbQ/5Mgdq66bg/NuiQyM3Wy1rXT//
 83BIlQi898yZN301u+FKxrE2KCALXo8d9OdHnuPr1NpiaNxajgzilXEtbUycX5mONb7suh/Rw
 vuP7yx9IEPtk0LPyZVoKs6yt8w+ZCc0HOucNdRZQnq1oA=

=E2=80=A6
> pcie_capability_read/write_word() failes.

                                    call failed?

Regards,
Markus

