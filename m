Return-Path: <dmaengine+bounces-9041-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLBkK78mnmn5TgQAu9opvQ
	(envelope-from <dmaengine+bounces-9041-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 23:31:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E12218D526
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 23:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9641E31399EA
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA4234F49A;
	Tue, 24 Feb 2026 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aM2Goi8L"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C3330641;
	Tue, 24 Feb 2026 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972075; cv=fail; b=HSBqZFtaBIw/Dh3ZrWyE5MQhnRY52FFiO+azSKdVnKwr5rpfzuUw6mww0Ybic1GfkwwO8TQ3uYy3ZRKNbSragCZduc3dASp2Y9Q3UDM3Xk/T1zrz7emFF+FtPGpaFf3t1FURze6Ier6eLSyQAm0GFG/Kn57waRAsps64lOwcf8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972075; c=relaxed/simple;
	bh=kVAI3hge40/0f3Wln0GKbXNJp16uqJlbbMFPazKaE88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FjK5G7PvkyOfX/EWxjreYqC0pMbycKK+Z5Nxfq1KYPxzRk8kT/8GVuxyYuB4y/LOVujbV/UUds1qIr1ESjR7C3mfSJ7Fk5pxu55tF9ojVg6tietBvmdVeJJvl9hC2QktipBMdugzJ0Dri9vv0NpwP+8/36dAAnDUAdk9nbHepO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aM2Goi8L; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAluu271HlovBQN51gq5df/YpkA8X9XcYBRnyqTF16hJADtmuGrVnnli///6LvJ0XoyYVocrARrcv7t1kV9dMbEogeW5sCV7JtA4gOTlVDOd4b9cDkS5gVK3aMpTrsMEXzshQFztr1qzUylLdi3G/ooHoPLAvWLqP+XOA0syAlObrD+pI7BoCd8XvcWQ65rgOFA0zhDPn2nqcNOmAv8aJ9/w6r35mQnuRu5tZSLrnTJclOvsbNdDKieQmNPys/6vq3Wv3nHtWc2DqHOsXrnuWnyrVgh2Ty4IfJcvaXjpR2X7fD5Lnyng9BhHdGT+PSlmd9kaB6H6LOAmVmwQct380w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpiriHS8XHTwizb948Hmz2rM+CUz7yfq3aCyS1qrY/Y=;
 b=zTWzwKg0krNFDQB3rwA2V72LTB8zVSpY9PAlQZmjvlgwbxQTTUZ26IkfQd9qEhoKTkFo2wLZ2tNRxB1dMwOMf9W2P+UKEIvv/IdTFY5lwEd6RoCWsy9Da/UGXDOIg0BY4ySrsV2SEPm1sqNbWGq2uOgLfY8/qSJWdGZ+sjYPQjyRCxpg1XuKvaFdrMVTdjpxnOUN21by/39WKoKZ52TBnpOkA3NtoKtvmTzjUwlTAdr5QAFwWMsAWh0SVxapB0zm1S/4HvtJTUgqv+xuqja4Bb9E4hJSBnRDXGOLBL0Kowx4pDAUqvvaL+S4Qyq4GNOs/BB1WJED1Mo9dMjbQQhc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpiriHS8XHTwizb948Hmz2rM+CUz7yfq3aCyS1qrY/Y=;
 b=aM2Goi8LP7QvVJ4CUzVoG+29w9eKePV1/5mFy6/6Glvz3MpfGLd8qsZ21SGRB6lvBXk7ZJNPbcvdc+CVBElLM/FVyA6rEC/SW+8vIUbMP/FsmmvKjGXfdDmjgWvJX7Esk+AmJ30c1FfyQuRXdZqp/2FzJHpYerkF2uJlCNGCkRZcrp9UzCSBhYvyGXeEWLtIFMW36XNuFnCuGIaDNxyNvDtmGCukoQJWJqbMRnVustxkZWk9Hsr3kXYMzO/PJ6eBVygHZuqI/h8WzrqU9z6rLyZFWpJPHIzn5VwGRjEmiOKqmN1IlAP0NojDuF5mTrm3W0u+dcPr11q9Y1TTptabTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 22:27:51 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 22:27:51 +0000
Date: Tue, 24 Feb 2026 17:27:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
References: <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA1PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::11) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ca21ef-905d-4147-747d-08de73f3f1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aa0vPH9MSgPhkBvNbcefyHiFQVQiSVY3XeTODFzJj0TpcFMR7b273o84typ0?=
 =?us-ascii?Q?yMpTwE93YKDzjFf366yOMTyzyVz1cp8BSLH7QtCHgW75BdyRiClN/qtuFhn7?=
 =?us-ascii?Q?HsKxhdL+OedBGF3YiC3VxTgiOsgnwFo8IWiwuj/GJXfh218XsKPykPhfLpBy?=
 =?us-ascii?Q?mfzTQExU/0wUtyYxrRUQKK2dPfwCkVs6exgdqtHc5dE1lSCtU43aaFtXAFQY?=
 =?us-ascii?Q?t1ayTNSBl9/JKr4IigQrlt5EYMyyWIcQCJ7/HrMoVR/KoqHrAa+rMe9aYQsq?=
 =?us-ascii?Q?bXt6OvDfe73VkpLjrNMnB24lb6MRFN0krpj8MmZ5pC48oa0ZpXN1cjCZkKJO?=
 =?us-ascii?Q?GguimBSwRZLnzV6pkbHGPeGJ5PCqiDOKGb4D6yaC4cZ6fVNBEyV2E5J0iweh?=
 =?us-ascii?Q?NY5mBTvDxvDL2XEYUcmmfVw0wYxYk85vUfDuaSeR5B6aSbK/62p12f+iQdvE?=
 =?us-ascii?Q?gkCXi+MI1RcnkN1uHA+noX1Rc8ewyaNC7fC7cLKU3sZSNzK3WKwilsp+Sn3Z?=
 =?us-ascii?Q?Fe7CXh2gLjLVPTqm/KoOkrnH+sHBe8SkEuCOG3Gxy8vTTJ0bE1ThXdffYcmP?=
 =?us-ascii?Q?RgYmgznej993BAHmqkXrNmkajloH258UgQwoRVbTW6NEOp1jKrq4q2BBivsf?=
 =?us-ascii?Q?CA+N+vyQJWCvRbNzp9l/YmiEUcZBVfSARmnF4tW/Kmv0vvczGlQlckf2rFmh?=
 =?us-ascii?Q?MIyaQzvchbZXEslxOUkhHMBlHM3V4AZaXspWKsIxgVNoJNteqBUgaSOUmbY+?=
 =?us-ascii?Q?1y8Me/FusgII0aSa0CXGUCTvT6pTe3zyT2SDfSjf3uqD+9zgSKutM5Dg/3ls?=
 =?us-ascii?Q?xnJSNsHAQV5IS1T62VXjpxGZM6VrvCcPeFUkVLXyRLJi/zqxCG5QlwtqC0Ho?=
 =?us-ascii?Q?ylGwqJLSYu6PDYbXnOCpAoCty8JMeBbkn3TcuZBjE/k34m201zv68xuUCZYK?=
 =?us-ascii?Q?4UzEVoTqA0bzstq6astpVZXgkiCKnVO9rmr9OYRUDPcBi1lcFcZCbtdqYMjl?=
 =?us-ascii?Q?XOvwwQw6FhT0DKZ/AOEcBTvEVdRijTME+x2QHpJ2S/vrfQBqzRmd37zaE6bc?=
 =?us-ascii?Q?6PFmCqdWarNwF7C0hvUkPTrRIm3TCjeO0bDhTX34RSBdGhTFy8UAQNzj7MeJ?=
 =?us-ascii?Q?mwFcLW/hlm6p2DDO9y+2IFvxSeb1u0pPABStH/Y3r+yFrjlTNqChzXsTDtQb?=
 =?us-ascii?Q?/Q7RuH6VQZ14VGhw5B/btJZ4SFcgPB5HXl9ZH7EqpWdH/Yrpkq0JBPFROHAB?=
 =?us-ascii?Q?ztlFwpjiYcoEp/Lp/hwGYBKUYtVNLsEgCy25dL5j+WukuOY/mabLQiaieotx?=
 =?us-ascii?Q?AhBmvR60XvVYCwN9zit9hbx6ZKSzmpygwoMb0pvgDCRL6vxcDVFMCy6EXGp+?=
 =?us-ascii?Q?GqCZXwiDmzdTIYv0jJ75XEheDDYrBurZUSrC9Yrn4Tv5LrwxJcbqdT4ffmSX?=
 =?us-ascii?Q?YhvRXTL969s73hxIwbYz0cUhnMlWbsJW6kotVxHbDgEJ/itQQylUhTDBBj56?=
 =?us-ascii?Q?j8pZsIAOnXHL6QCk8miS3gTVNE6vd50byWHvWyVFNcGyBEWej8ar8LsmLo9J?=
 =?us-ascii?Q?Fkr0cKaue3e/fbHZznP4F7CUSwkkw5l9EiJyAPjLxH4d1y6THPjKGyOdm0Nt?=
 =?us-ascii?Q?iJJz7NIAo7OVu8VzKgMjjaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c3vVb6DE/GibysxnJtdQYkucumVF6AAmbSUK5CkxEL4pee5kgVVpydhD/5/b?=
 =?us-ascii?Q?+plbdZQtiCG7H7MmdKsLXW9a7YHZr5LjurCC/tX/xQ6nJPmvEdm4xMnK3FTD?=
 =?us-ascii?Q?uUmlvQ2c4Nn7CClpKO61Qc5NDWXArzwvayYrx1MNTRYDa4ztaZXd5asM8yPe?=
 =?us-ascii?Q?aGDq4My8xGZFhgwmTvUaF0TAPwn1N2J7M1ltrRYeg0kkIlPLyiuTQk16MeRo?=
 =?us-ascii?Q?hpRT8gYdLwQ379eBASuSFClT3u5YDyrJPWsneimrePM+9yBM+9Hy8G1SyrbZ?=
 =?us-ascii?Q?pgLOf6FoSQ04q2vcPXN3C7qzl+AQaodvwjtrTacbxqQVuF457T5P9WLfUfK5?=
 =?us-ascii?Q?tTy3z6q30PpvQaShujS1lTJ1mPLf75NEoXntaVk5rKwEUwzjig81olIFGY3J?=
 =?us-ascii?Q?jbxBD50HEED+5rKC4FkvsvfkeBmiNfqPL9DLuSWqWmDAckURrCUuShFW/uF1?=
 =?us-ascii?Q?MfOWdl6ZpADogLc6Vow7n5N2PyyQjRh1gbDby5E3puPDPcnYdO4aSVB6zz+b?=
 =?us-ascii?Q?RsPtZo7E7Gbtbs/l9SRHqrt2/C8G4Sn7mr9MpMR2im6trfDhBQeygLK5t+Lp?=
 =?us-ascii?Q?U881QROXM7FmvWFv5+lIQUKb7CNiEl7TZuQ7/52A1aocIMMx6P6/NtYRnGar?=
 =?us-ascii?Q?Z1kfZxfKJEnwzfhDEeMVDAlo9kX2YYcGNl2fvQNlMHHHTzB0vffuEiquHdsN?=
 =?us-ascii?Q?O2rrsw6LO3DdfTgX/rCsqqQ14jjkwL3GzNw63o/H2U1NknXpV3ao1e4NH98g?=
 =?us-ascii?Q?kxRxJtvu2vTXlfv1OTH8axRujIVFEhRlJHN8IL9MWz3LmE7yzm0joUnC80qK?=
 =?us-ascii?Q?FcAn0fP3s8KPoy51Py2W04nFwq6nPE4Z/l4Wqj19qY4gDue2qJPXPS+pi5lN?=
 =?us-ascii?Q?T/U2i5rQq7qqDBDHV+faz50XFXeny4MpqqY/JJ3bjfgYreoMUd5pSoTz/0Zg?=
 =?us-ascii?Q?ZCssY58an7Cqwl8Y+48VuxTDSYgdjlDk6PNsVNE2xxKsp73kfWbW2N9eVdMf?=
 =?us-ascii?Q?s9T5kLOLb5eXBmHatfISrzelf21fvSR7ovr49RGdAvmX3bXM7vYB/EIMDk6I?=
 =?us-ascii?Q?MALl4VnqU0IAhz3pHHTjPJY+PGUCOQPy5C+TDOolGy2WC3b3hQ4VnjOFqXkk?=
 =?us-ascii?Q?QXY15O2/YHSHA9o0RrCKU74XkwY2HLfYF1ZD1H5MN1sSq/9+kZJ+EApCJU84?=
 =?us-ascii?Q?5LyKlyeP2Zz8kyuChOphGfWk2tcSqS+xR7vsP0waxGdJITjzkStSxB8xP+1S?=
 =?us-ascii?Q?7cNpo3fu+EeQZqVo1VNiO30hjD17krt4tHIs3g5GE9y0uVYfwzbr4PGE9Ihw?=
 =?us-ascii?Q?zSVF9afpLJgNGbLUfPRBy9vMUw+S62yL/KdANzSUqIl34PhSGMICtAe6Yff7?=
 =?us-ascii?Q?WpazPToTBehqGpTerR0tJscD/og/gSpsG+3WSprY/9QTUbOjmE8CxcO+uhRa?=
 =?us-ascii?Q?E9TM4z9ZjybI+c025jSjfd17J7UA/O6Jc4lKR6M7vJhObJfOFA2RRTGX8g4e?=
 =?us-ascii?Q?jLDtT0A3ImhuuDXQzFCTa9xR/K+CsCP6xj6S9NO12R3XcLeqKQY3sZRg+PoL?=
 =?us-ascii?Q?BPBR6VMWuQUr669xHEvTE9e4Ta/kZ0DAAvvKCAxNbsSeuley+Y0kV5Lunko4?=
 =?us-ascii?Q?FEdmx7WgR3PQy0oZzusYXXxCfA5OlmRy2PNPzZ9jAjVU+Tm8GbWs/olfQIUh?=
 =?us-ascii?Q?grjLP7bzC0r+xPL8qBpBttTOUCVe2mg+78EfR5ntUhULaX3A6rre9BIdtU0v?=
 =?us-ascii?Q?c567a64cBQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ca21ef-905d-4147-747d-08de73f3f1e1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 22:27:50.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mufq7cSLVwFUTmL68RgK8TGZ4ctiYXMA0zb3uLGc6oqEN+Z3SzIUrQaSG6HTza1ExYm9ZQ5h4ipTukrvpYmAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9041-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 3E12218D526
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:40:07PM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Friday, February 20, 2026 9:33 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
> >
...
> > > But if it about writing a new function to check the LL mode support
> > > then I think the current variable is good enough which provides good
> > > readability and do not create any ambiguity compared to the ll region size
> > comparison.
> >
> > It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip. So we add more
> > cap flags in future.
> >
> > Frank
> >
>
> Hi Frank, could you elaborate what you mean by adding the cap flag? How it is going
> To help identify the overall chip state?
> I do not understand what is being implied here.

non_ll in chan means current status, which indicate one channel work at
non_ll mode or ll mode.

here dw_edma_chip means hardware's captiblity, indicate if hardware support
ll mode.

Distingiush hardware limition or current working mode.

Frank
>
> - Regards,
> Devendra
>
> > >
> > > > Frank
> > > > >
> > > > > > >
> > > > > > > > > >
> > > > > > > > > > Frank
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > --
> > > > > > > > > > > 2.43.0
> > > > > > > > > > >

