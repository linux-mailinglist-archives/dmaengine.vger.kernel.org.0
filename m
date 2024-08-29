Return-Path: <dmaengine+bounces-3007-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB19637E4
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 03:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C588B218CC
	for <lists+dmaengine@lfdr.de>; Thu, 29 Aug 2024 01:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF336381D5;
	Thu, 29 Aug 2024 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RSWbutxC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2061.outbound.protection.outlook.com [40.92.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7F2C18C;
	Thu, 29 Aug 2024 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895601; cv=fail; b=bkAwqinKaGuwTwPUd79kzRKPeDo+Xdc2X4QugLyhH5MaS2PKcJsfa3qrgLe0VV5iZmitiQWubrwimjmRY5fE0rMG6U0d9xoxAemA03d01C4rRK6E54C/OMZQhRKtEnW4/cH2oTjCl9OojMTzZ6iRaSQu3MKhwlJAwCv1JgJr5oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895601; c=relaxed/simple;
	bh=N3CcvP8W4sF++cNhzf8cPXuL6nZ30UKCofP5tG2MGDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bl0Mms8Lh+EDcBGzavZjd1prDZFjfUQtGrfiZZQAJGkK1UEItKDhEaYGfd9SNyQVEpi64xOn5ljwyDOMHEnuzo48NbaTVKx349mrQciDFuX20Xii0p7yPV5mcIPDrJrEtsVtIuviyfRQrgAtkTdk8JpvyOYIYWktBnYxNaZNU0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RSWbutxC; arc=fail smtp.client-ip=40.92.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaiZQdr11m8QLIifIHqJIB2K7CTzg3DiCskIaEusN9a71dfdPx7GcN7Hi0rCzrJG/6MsfLVaiZuN7dthrxJ+rSvlpygfQnnn8qw18JZWSVkE2XDGHV3eu9RXyh/ExCFwvbAWoT63mgleBlQUwl/VyF1coV9lB2Vh7zu2Hd6yogCj1s39sNNqeZ1ZquLXmPPfpMt08Ytj2yplVy+LZ6CQqVuM1GnINZY7QJaHvZINSQ8zg5B+buy3JR22FUb9SV4uh7w6OgwdQe9SKNm2DOstSWpuL3FuFTwhmGWBcUVbluvGjnSQbLlvWQbuO9MCw7pskk8HDKU5svEvVBvbAVY1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnRUI/yda/w1f93jz50UfXrUJSSCaVq5fTbo55cXh5Q=;
 b=wkZZ5Ygr7Ikn9hPyHbbfa4+e+jMEG2jtw3bg77i1aOHcloTuDsE/BwD5ht56i0zkh9LBKawMEfuwebCiI29Ukx4vFroRbQdXCMs5QpNNNz+nJWPASyV4tCOY1SMqpR7Pyb/Uxx8xA1dyHOtWVaxEPxsTdIZTZ6+9I7SnViw6l5Sq4VXcL4O+uLk1B+dYBIPiq6nU034HW9/nDQrk0Mi0ojWcfvn+OP6LIBZYxw31jdhQppDc6Y5Lj7uoKstTKhMiqzSjogHwsk81HVp5Rxj/FAdw97h7H6hNYzu/GLmU8G5MJMouC0Xe4AFBxny2g6iGpXeizBUle73vjUXyDFKpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnRUI/yda/w1f93jz50UfXrUJSSCaVq5fTbo55cXh5Q=;
 b=RSWbutxC9RLVMVFIAh1H55MSg8OQ8uc3rFPqOH8rSHGM5JnFpWTt8UzQ+QalCsQeo1wQza52C8FeGB3JK04JNc7O1dgrjCGT1FFr+e/Cv7yK2MntUOjktIsYvaM0aQd7YE9KMqnbtubK3Ve0nOzVQWV4dSWmLU2TmhB6xjH5l2Q1sbeZcMTMvV0biEOE+L+4bKSx9WHbkOXGkDmT1jXQlZ2L1cQELT9RuuuPdevVjuMP6o24kOglcJqVVfvFrNyY9/QjukyVJPilSJLZCB11v+GXdOusuyhAYbuDzn9C2/iPYXHVl97W5RZVcLeW12gQTxMCwSAuxEBHf8S5yfz1eA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB4628.namprd20.prod.outlook.com (2603:10b6:8:63::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 01:39:57 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 01:39:57 +0000
Date: Thu, 29 Aug 2024 09:38:54 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 2/3] soc/sophgo: add top sysctrl layout file for
 CV18XX/SG200X
Message-ID:
 <IA1PR20MB4953572077286AF23A747507BB962@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E0D56CE4010C470E4A71BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
 <Zs9kUAeapWeN/4GS@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9kUAeapWeN/4GS@vaman>
X-TMN: [msODPUb8O7784K0qpbtwfL29OeOW15iY007Od6JDmB0=]
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <va6sh7mcnujt64b4tmldjo56ayxfzpexfsomyjocgxx75azh4t@f42fer7c4qy2>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee9635a-777a-4b83-a525-08dcc7cb7d61
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|6090799003|5072599009|19110799003|461199028|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	zEa8Bi/IDdAI6RcdI9KSXxoh1MSnrRv1jL8ftuAh5x8wAf6JDoIqgqfWUCGeYtTvjRBndjKn1XOEOFPqo4ftrXCxT4gCPKbvLdy6550iEFq1dAppqFZ1voI3bqpS+enwLIP+Gw+YaOU1udEDzGMN4uv+9jqB/BLmM/DKPm6As9KWur5vplujonMqHmZ+mQdzC0Ec5EVoQd1aeEa/O33+icqJVe4qyQLt52iYNvRsaYwWpbwiVsYt4iavOp89vpToVDfe+LS0Bmq1yQ3/vbIcXlwCZ2WlIr2lcdQF5HalwBU1nNu7aKTcxOz/xaK4m48sJBfyGY/voE8K6oGDmrZcWuuereV6vRocgDf9oeq4WXvNCCGW/76maGOtWmwnmrzSDCDMnzVz5o9ojaYPRNk+T7tCpg8I+PD6d0UmEXPY6qubWOP2in8TNJdqs/gR+Ckb6S0QoZsWjhJcHtZRPybRpgj/vFNS5OU7QJqUZ0MG31fiLKb39H/rbmgPhwfliBLfvY08lrrD747x1zzK27kXsaPWwSma6YfuI/eSWcHW23Y8ULouvNxdZ6Uma04y8PzFoCqdhoi8NOeFIGraHiLXjIv1EmX/FdWZtKHujjK90nJqj0ft2b9cvufaJMCDiGDu12EGqs767oJ8Ro6wvo0HzHisWXdw2QjELFkz+yKZPz73qQtG3hXiXiggVnTjEFOYh/4n1Ax3a/UDoEmZ1FpmXlCWrwT3y5nAlYzO72q0xK5wf92t8EvzU0hnj/7Y1n+y8JP4JVW9YxNxB8qsEjIiFg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewzx3tHmdkZ5c3NaZc9LNjnxG3VVs7+BG+9bxAGYbdthDPA6aNgimRsp1Rbf?=
 =?us-ascii?Q?FWAF+cd3XZY/8v4CHZWkDDIK/65JCWX09DHTmlbkRpfah6N8P0rYpV42fT2N?=
 =?us-ascii?Q?Y8siYVBqMGkkLsFwWOTV9pY528EW1E9459iWwkWLPkfi2g4qxfjJGnrpePAk?=
 =?us-ascii?Q?3R6Bkjdar2vw5VPu887RGrOsHP+8y4EYVVG1H9OggfXC3Gk+bFyJI9kGOKaX?=
 =?us-ascii?Q?HfO84xOUpLCGzwOqsbBoTydo3MEMNnaoF/wi9pDPuxGB1ku1dFAn3foN3mlP?=
 =?us-ascii?Q?wWYNUYvf/H8Q83Md7L81DFez+SbF9zKY84q/UGsllXYkPLdn9BZ+mGt7BrHw?=
 =?us-ascii?Q?GBSQIoIj+IqFpfYkEsp/HLJt+2320/zmaTuYaqjvHvmtN++W6AEttFTlXaKk?=
 =?us-ascii?Q?ml2uIlqqV7EaGZADXMtG5mucBirDRnHkcn8Wlki57FFh7iThJ67+94+/kGVn?=
 =?us-ascii?Q?dtkRgHZcFsZEzc0BpSpB9+tGXzJeaFvYD0FKnZDqUmjSCMvaX7BHPU1jLLUh?=
 =?us-ascii?Q?t1qPc4UuxKuctk3tmNcx+jO+8JG8NWTG3GS03wYMY6CpWu9fMKYp+H+7jBwg?=
 =?us-ascii?Q?aAvX36/biTJl6m7v4H2jUDuNh+0Yc3E187wbTdsrRKRL2ZMAgDKDE0wLk/91?=
 =?us-ascii?Q?G/aQWFkYzGLokxUlP3jUrDYNSP9z/l4ahS8GIjB9tPQOLszJMbBJ5OyXfMxm?=
 =?us-ascii?Q?6EBeAutdj5+2+Kb1p6R0JYz86759MRU9fZnjzWNa64fglRugSew2353yuPzy?=
 =?us-ascii?Q?MwuP45yFBL6GNRdrnpkb5wmE+X8I39U9/8ApRE0/Jk/Md3ZJMivPZvMwtdio?=
 =?us-ascii?Q?itIRhAxt9Nf/BYj9Z5PhwCsOsLEPO5z27BczoHqqCwSO9hWG4yxfi6/3jHPs?=
 =?us-ascii?Q?M33TyOhCpxekh18uprYiGNk0FpQsdJmIcG3cm23L6//fS9feju7uz+MUzlk9?=
 =?us-ascii?Q?P5c7qOdegEmEcv37yHg/y2HpBpiq2jPUakf+2kXn4WNuhLPXzNJw+eX34IxB?=
 =?us-ascii?Q?cqUDOKcttFMCzyNaWllJpYc5zbG4tzmIiyrz5wcZkBtL9vFH+0DCk1dLkeDB?=
 =?us-ascii?Q?4VViRw/Kcsoctz1i7KuYusmKHaWGIAwurIM7uqMmG15X/sk3FMDkzY04KkNh?=
 =?us-ascii?Q?vst1DKP5BUO+gcPyshVv9F1v2ft6ijA9TO/H2OTGtOJwbjQZYr5MqKng2Hgg?=
 =?us-ascii?Q?bo5l9D9kUn/KXR03OxJPH3r2oAr01DL10h9rCUw5T9zlL2XlH1+Mjgz1FBtX?=
 =?us-ascii?Q?KhNrlUA77CvGQe08Ahef?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee9635a-777a-4b83-a525-08dcc7cb7d61
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:39:57.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4628

On Wed, Aug 28, 2024 at 11:24:24PM GMT, Vinod Koul wrote:
> On 27-08-24, 14:49, Inochi Amaoto wrote:
> > The "top" system controller of CV18XX/SG200X exposes control
> > register access for various devices. Add soc header file to
> > describe it.
> 
> I dont think I am full onboard this idea, 

Feel free to share your idea. I just added this file for
convenience to access the offset of the syscon device. 
In fact, I am not sure whether it is better to use reg
offset. Using reg adds some unncessary complexity, but
can avoid use this offset file. If you prefer this way,
it is OK for me to change.

> but still need someone to ack it

I am not sure there will be someone to ack it. If this patch
is kept.

> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
> 
> is soc/sophgo/ right path? why not include/soc/sifive/... (sorry dont
> know much about this here...)
> 

CV1800 is a SoC from Sophgo, it is not from SiFive.

Regards,
Inochi

