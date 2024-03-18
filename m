Return-Path: <dmaengine+bounces-1416-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB2C87E528
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 09:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6721F2111D
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 08:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074E286BF;
	Mon, 18 Mar 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FJ2Mku7d"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2029.outbound.protection.outlook.com [40.92.21.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CDF26AD8;
	Mon, 18 Mar 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751655; cv=fail; b=WHymWw7Bv3W0YmqjW+O3qkV/8Xy1yLLXNkwVJwsNSipxEdtm1zYeIn8o9uILrc9iE+27jaVUvmswPaIw0KYzSutJzzYHjIvhd9Qfuvw86BAjEaWV2kN9A3XuSSzNP/E3RNRj16/H4GVo18moRifYY4ytoAIhDY776Bt9yuT9FJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751655; c=relaxed/simple;
	bh=rVCkbi7ydPqvjj5tyqWe95O3MrbFlhyKgyloUhX6jfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EAavTEo/Tjd/sMNUcmNGGiziR6wqtawSRnlFwPO1qOI5n3pydInjzy9QRfxVJeg1QAAI0dfQ8LKl+Y2lGJaKHTc55DG5tgwoA48dZaUjdaiFeCTlxzyZMT4MAQO5YWdhLfYeCY5EWkdhNVw5dVSTE2lEpIZoDPITZnSXjFvL8R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FJ2Mku7d; arc=fail smtp.client-ip=40.92.21.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljsfz1m4MUL+mYO5QCIU1G9bLioYD5tEjcOoug9TiP08JTL64pCugKSgW7ZZITpICCTzZFeJ1saCcV8ZHjB/sq2BYOk836jmczw8Iu0OlGSN4bxP2L1UxM8qg8HKLFktsaf+Yn0FolfoNh5chjpNwxPtnzPcKgJGV1CSwoneSqjvJsaRWesfuMrxFtfl2ckdIaEN1kXcVFONDYUImrDz/ko/IQUf2j66XwLguHGOj+WHPb7UY6SN++PMg/b7xrl/tXFW4hbrFviXYxArzgTW0TnA1hBaD+it7B5R915EjH4N0WF8i/pnIQN6xMgBaTcKLvrDvkqAikuuHg4oszwM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwz8N0ZF7M44BCCvkPsWBLTpOMS0L4o9dJKkRrPXX/0=;
 b=HsavA4ReXdXlQP8akCVFCyP630ztKITRL3q3ApcXP4vtUr1/yrIZ9oqFzSUhpxEjhxy/H26mu3llasiiYsBf1BWL2Sr9Cv5UaaXKG+E4jaKS1a6oIpE01vDzl8BYFFsQh1hUbDWO7iK2qk4j4UdT6nG5nxLRJuPErJQIEPbBhtN44/mSFqRbG0i6KRIdMtIMAoYq52mQxIXN7BiwO7G3Fg5jtzTB5pDkxyxy8FcIE5zSTD7U/br2c5PPsfD1+S6LAGSCHqRDENzevlT9eeCNkl7zXWYFS5abPL5hJyQYEi55BepBrYM3WI+7iQTNi/Yk01wVGHvyWiQQfZ4jmPO7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwz8N0ZF7M44BCCvkPsWBLTpOMS0L4o9dJKkRrPXX/0=;
 b=FJ2Mku7dhNwpWy1wHxFJcajn742syXt38vnSwXJyD743oHrMXN33ESdcKlrYrX3ZYBx42kVlKNPAzzRupue8WHk2iIhrJnpddlyLN+018MIYkc3fgNxiUSITOldEFrLNUYlV+tHXqv1db3lt0hZovam3n6Ak+viI6ifCYj+huhomTWtliTiNzSe+9EyhFJeqRD8952YDxaRSF9qAkhe1zkiKGxMB01KLWNdHY/1OuW8irmTn0j+vMtEJCerjg64TUzwUZnaGnW1TL11Etvw+oU7fBFgzUmgQyzXAxx5HgmHVTKfhX754CGkP/VowBbOguq2NcsdRt0bJxs8uHwdzGw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BL1PR20MB4634.namprd20.prod.outlook.com (2603:10b6:208:391::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 08:47:31 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 08:47:31 +0000
Date: Mon, 18 Mar 2024 16:47:30 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/4] riscv: sophgo: add dmamux support for Sophgo
 CV1800/SG2000 SoCs
Message-ID:
 <IA1PR20MB4953A54849156FFCC392735BBB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <c312d643-cf77-4a6c-8368-bc30d1e54b4c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c312d643-cf77-4a6c-8368-bc30d1e54b4c@linaro.org>
X-TMN: [PVW+qIFp6RRuctlxNlHWp9dnLBHeHeJOToD2R/l1bYo=]
X-ClientProxiedBy: TYAPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::32) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <z52ydak2oavgzyhdydqyftkd2flp5zgozzr6el6vfxqkrh57mp@copi7heiky4j>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BL1PR20MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: 5572fd96-5676-4775-d1a8-08dc47280c49
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qUQWS8lN22nULkf5597sA7XheM6xtakw9CvnAZEp92ElO3B4K5gVWJeXJD8wcTuXCSVeIYuBwaR+CuRY3Tx61R50I7O9reIYAPfKs+n3ef9lWqQ5Ik7vjek1ZN2BrTpWsCf7YqyNHq9dmgTrWeIohxxi/eCV5EmAI9v3RwQxRjgjNa5ey0EFo+S101JFaFJNI1rmI3JZPECzmSp2B4M9WbNpIhXCtIAmhwXPcA+NPvqcN9TDSPLCwD5xRLD3flCbUGrgMZ7X75nb8NKCzUc1/TqYX89kCKDPqDkX5QjS+UdmLNxULFqAofXVxcFCOKjbr54wOVNIFDxbylj/5bay1wENtSBCdnkrwSGq9huk+ohAgdlcWzKGvHc84a4zZ7OdRNNey3DhBDPYGw6k6OIz5TkiMegRwO9a4QSxaMRYxf1mVcWA/3bdCd4mcGg+ZEAxVVuhPrKURd5cUVVHePrl1ZYk+Zu0qXvd7Q/4P7gfJiUdc12fAZ7TxfccL0qGQXd7x1gduI7EJXaQbYyAYMDw0b7nu6ePk0+mRNGm+uKK1a2Xi9V+vC9IvYtNRqUUJG9AsbWF+QShLmWbsw/Wza1WQZRx8OKxmwdiaV0AmRL2hrgoCrwg1R7MCf9cafLGIhodxVwA0xcMM4bbL5hjfXev32GlPSh5CU0I9PKlMaUIv0xn5I4eV2nlbZfBL41W27xsGCvjbGguGzVk5f7SHvIJPTZsmlubpqMpiLj5MKE7saJKpP8b9wXUjKXqAj+vlE6y50mwfVvuM+iFRp7WysJSzWj2tDN4yxqMqYFiCoVnc+xhhRvnV841WZ6OeQjUi9Y3W1SSyTqfa5R65gRormo4icZ
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SnI38zQMa03GV2+uegz3G4jw1lMan0fDREt71n+rsVQ8WSlHRJz66q4r8BgCdmz3iv2YyRC88aIwUExwKfACcXI1ADrKSwT/llQtz7/BVNb3QbTs92P3Ce15PDtWa4v0AKKAj5ka/pt0WwRPPkKOJimjb/kvwQ+byf8gMoQzVFs839iPb2AeflCUenDPC+lN2yM8LIV+YyrrlH1Lqjob+shwN6YSHFuCVJEyapuYbmmSGwm7O1su20AmB00sIDDEeYQWP3RHuFeK6esrO908+PW6/2ZU0CrCFbw4nfu8tw7Es/gqvasaV+TkH/lUL1GDqibuyJ1HCeL0GPTI3KhJEyDJ8rLdqFCrTl0wZ1mIWyw3n0zRKLA6g48FjQRNT6/YVeS3B4pNumS9ntQBZKAhfL3k0ALtmqMWHD2cF8roD56a4LeS0Yw3E/nBvy/lerbSqmznLMyw0GRpXLeFlBpEx+mWndCMAUMRFcADYY6Lec0zlCIAThKd7lP+MvLVnGHE5frnkXETr3eY8a3cyUdmvNpERKscep10cxJ5VHT6MwD7SOpDxASp4oZBVfg7xAWIhzL0ijxbcyJfhQjwpLKv0+8yPVn0uyNhnGdCRVkn793E/2hmtaAYOQsI+RaAcOrK1T3vBFwh38Mnp13uRH6MYqjvpPW2vr5osPRyHo4jMQ9rNQnm69aqoTODyFkF5K8o
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1TO1UE8n+WdFcAEDixsCVNg2iNnbaidKoppKwcQPmr3lWfIZETBAb2An+7F8?=
 =?us-ascii?Q?EWJwBB3pQh8cZVl+/G8sAhzzDTVUa9w3vRzN4kbgwV8SsQX4rwu1LGP2Tijr?=
 =?us-ascii?Q?qW7gbGIZz+DlpDwARuCRxz+Pa5ukKLXrkYyhRgbQS0SDAM8mrUQkz/PnQ5X3?=
 =?us-ascii?Q?nWTql3fIAvCkrGyLwtTGdve93JPsKSIse0V4r5K3+g7pRix7fQ4VJvi0eKjT?=
 =?us-ascii?Q?ot2q4VbSnOlja9NiZaRjarTjkaKz+9sSlFSW+tSP1rpRHHin75561o28bXtT?=
 =?us-ascii?Q?FtPqUYcZiOUHnYqc7X3Jf1Jt/GRg9JYb77WXs8BzXl0RRPvbXUEmDx6nTAvH?=
 =?us-ascii?Q?dShXlOxMaq4VQz0gLptPW4VhrOFH0+BceHCbP8NqIjNhFRXvT/4D/TXx0IW0?=
 =?us-ascii?Q?ImzsIs2RARbqq+QGlAKOHxQABNlOX4MbPhmAf8a8UbU5kjwEdxmdmFnrGWlN?=
 =?us-ascii?Q?Yn/5ngH4WhHSOU9KzfPjXkywMYbhlNg8KwSmZZyVw7iTXtmpyPsWzSzCCBjE?=
 =?us-ascii?Q?2MuMPlrZUUT3JwKUz9JCn0TGs6LQ0LY+w+hJ4ZH36YOcJJ/dO+wHYZ0+rr1I?=
 =?us-ascii?Q?JxoLFYwsBB8iqIRKwatepjSIADQXHfl2yrYF0jxOJikcDjsB8K1bbGnHPfX9?=
 =?us-ascii?Q?CsDv1ubGgugR8m3bQHtWhinRMbPLgGa9G8oL/dlkDp/54PDGQYPrS5dSfnrx?=
 =?us-ascii?Q?fpM/BsrgM6vmBi1wJ+bR2OGryec3eUvBRUbWN/NDFlc21k/yIlIEibv7gH3s?=
 =?us-ascii?Q?Kw9Uc8lJf8uw3bh3eHx+ArQIfAn5QKc3TNTBeYm2FNIAePhBZQfVlZ4quYZI?=
 =?us-ascii?Q?50Rf40yUK+o8iyTP5EKzBTOlKeu/+VCPcMulEcnvrRObihY3LRDniTZS4lg3?=
 =?us-ascii?Q?iWnZ05QYd8SiylaZBAHIPk4fpoGOsqlYZwiyT7e5fbdj6LFP9lkrM6qm8V92?=
 =?us-ascii?Q?+tRJuMcbHTiuUcutyFG2RpFytJBQI8rNwvH8GCN2tU0ggmGE6HBF4d5h8KSB?=
 =?us-ascii?Q?kg6Pb5fUjwJ+MRMzbYcTMCGwBXSreaQb5K/HSDtzGLBdrmUfv9c/CposGPFp?=
 =?us-ascii?Q?68oQGbDgfEUHwMl1bVjTGRyDnInlZ7WPpAUtPo4GYLCZCfgrC0PEMVKMm3a4?=
 =?us-ascii?Q?3hTBqBdZEZgrp1fyDmKYjKVPflb6e7XJxT9jkXSuty5sfBhxBXukqY71UUOr?=
 =?us-ascii?Q?2HkTLffaS9HBUrkkUZae578MBTCQ2CZ+b1nzqOjSRqc4UFzTQjtTxhMuiVtc?=
 =?us-ascii?Q?Mrp/wukWwfVZc6ZcfV5p?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5572fd96-5676-4775-d1a8-08dc47280c49
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 08:47:31.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR20MB4634

On Mon, Mar 18, 2024 at 09:06:19AM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2024 07:38, Inochi Amaoto wrote:
> > Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.
> > 
> > The patch include the following patch:
> > http://lore.kernel.org/linux-riscv/PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com/
> 
> What does it mean? Did you include here some other commit, so when it
> get applied we end up with two same commits? No, that's not how to
> handle dependencies. Explain instead the dependency or combine patchsets.
> 

Because the binding patch (patch 1) included is a must to describe 
syscon binding. And the driver code needs soc definition (patch 3).
If these patch are maintained separately, patch 3 should go to series
of syscon, which make dependency of these two patch setis too complex.
So I tend to evolve them together.

> Best regards,
> Krzysztof
> 

