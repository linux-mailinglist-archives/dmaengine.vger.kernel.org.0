Return-Path: <dmaengine+bounces-24-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3067DC499
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 03:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B69B20D6A
	for <lists+dmaengine@lfdr.de>; Tue, 31 Oct 2023 02:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ECEEC6;
	Tue, 31 Oct 2023 02:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186FA4D
	for <dmaengine@vger.kernel.org>; Tue, 31 Oct 2023 02:42:54 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9C9F;
	Mon, 30 Oct 2023 19:42:51 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VvFn5Tf_1698720167;
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VvFn5Tf_1698720167)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:42:47 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix incorrect descriptions for
 GRPCFG register
From: guanjun <guanjun@linux.alibaba.com>
In-Reply-To: <656d4735-0e24-c9d8-ba9c-97f079d95475@intel.com>
Date: Tue, 31 Oct 2023 10:42:46 +0800
Cc: Dave Jiang <dave.jiang@intel.com>,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 vkoul@kernel.org,
 tony.luck@intel.com,
 jing.lin@intel.com,
 ashok.raj@intel.com,
 sanjay.k.kumar@intel.com,
 megha.dey@intel.com,
 jacob.jun.pan@intel.com,
 yi.l.liu@intel.com,
 tglx@linutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4F5CA4D-81D9-478B-9A9B-844BD15CBB32@linux.alibaba.com>
References: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
 <20231031023700.1515974-3-guanjun@linux.alibaba.com>
 <656d4735-0e24-c9d8-ba9c-97f079d95475@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)



> 2023=E5=B9=B410=E6=9C=8831=E6=97=A5 =E4=B8=8A=E5=8D=8810:39=EF=BC=8CFeng=
hua Yu <fenghua.yu@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 10/30/23 19:37, 'Guanjun' wrote:
>> From: Guanjun <guanjun@linux.alibaba.com>
>> Fix incorrect descriptions for the GRPCFG register which has three
>> sub-registers (GRPWQCFG, GRPENGCFG and GRPFLGCFG).
>> No functional changes
>> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>=20
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Should I send v4 to add your reviewed-by? Or you will add it when you =
queue it up.

Thanks,
Guanjun

>=20
> Thanks.
>=20
> -Fenghua


