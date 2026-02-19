Return-Path: <dmaengine+bounces-8981-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INILOYqQl2mR0gIAu9opvQ
	(envelope-from <dmaengine+bounces-8981-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 23:36:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8A2163393
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 23:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFFC63015878
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38E732B9A1;
	Thu, 19 Feb 2026 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="df/nNta6"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405C2EDD52;
	Thu, 19 Feb 2026 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540615; cv=fail; b=j/k58MlxqDkzjZIuY+WqVq39lkh9r/Hk/p2ibYo875cOD7fZMztYOWHfgHSJMBcPV8eg1Sx+zlFBOorEoQ7R3y4cAapwYSQM0bp3nnLrvJvlq8hJs6sWu5jGjBTOP0s1M6NYeFfbxP3TFKIkEP3VtGTDZSkE+VVcFIWOX8FlApM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540615; c=relaxed/simple;
	bh=tleaxewQI6x51LmSaBhMUDgCu/bkk4Z43IWN3UmU+Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLTq0eQd4bOQ/P/PH+6bEvOs8RlreP59dXPvmUrcsHlyd6hF5xIy/nCPgzmKRnsRgRWTZlIJ1xbksk9P5J1df15uvmZGfOhGl2ng2Pw3qt+7UbTcIclwqi49eaB9JPuNWEhPqeElo5rQd1nFL1Cdtv0YPG6Kp+WKeMclhn7v16Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=df/nNta6; arc=fail smtp.client-ip=52.101.72.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ6wgoJmNXxjKv5MaAOfwCgtYp1YLAz0Aq+KzL4UE2xhwpR/w97cFLKu6H5UYvC2F+SdZMCiEnitUUpoF8QTtUOd11WoMTWyvFfUDNFwN1eNemHIC1QzzPrTZj3dMsFSBIFlo39Hhhm99efHPXihMzDTRhg0LtiaEyyexFb4zgGcGuYfjTbdadPpqBmOTmlv1+6C7oGEFo7japcY4zKOF10JzJnSpGyXfUrs+9vXb72bBaAaOu0qPFWGOoCE9QJaioyti1V+HAcax5KuaY9exqXHgNEntb2C2TakiFa+TV62cHZARtMUjGZCPwpGUEErBTzxU/tOUH2vSWgTiQIWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6/mIAZdri/JhBrqmu4leeYU+lRN3YVwjLWY47JL2fw=;
 b=AZWlCOR9yqINPpc7L7KC6+z6SELbPODNS+MGNiVq3mHrXe+nkK8GqGbde95v1ECubk+2myumKMXQfNyEN+a7DuupfwkZnO6MYYCSLIVKxSLHYqUkILhu3tUc/LiB2dtJ6KuFVYnTuiMOUyINDAay6oJL52vC0oJ/AQKfHnLTo+5umE+5ZCxEgIFE/Ar7mlyqk+mWEG2VuZjr62oW0ni/nJ2kozvve+D1oUgzXaJ3ZMV2CAcaeOu4vtLmWWKUCqXUNYT2r5cILTcZYyT2DHSflenlfVrwW5y6BlHDt8cZifZJq5BFoJdC94K2mlOytU5LrLZyVrFONF7KRDjl4Oa7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6/mIAZdri/JhBrqmu4leeYU+lRN3YVwjLWY47JL2fw=;
 b=df/nNta6ymeJR6bXRw6rmz9BdBLI+xnbT63TBAPZCcJyv+7ievtQsgRj/IEEKZviJbHP/P3x1OyQhTCw5Yezq1JWAPA0wAebV6JihCRmsIIkmWrvqjE7Zr36tl5EGlj6umME8u+rMJEEaVSAZ+o163cFe8KG+0tikDQ8sWWlLQBzwJhc1gS8UAWZ5vOd2rOxB4S1lHIZgWEbxzMAK402mZMJx62vhEKskvjuVbiF6ENy5Sk6GcU4RKFjxV7W3/IAM92dOEIdVHwgoXS/z/42TE7WyLDg224EtROPKPoWltpBi3bZBhy7KjLHETpmxyyFjxC5pVP4ZDb9/LUlWhaNeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB12065.eurprd04.prod.outlook.com (2603:10a6:150:2ff::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 22:36:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 22:36:50 +0000
Date: Thu, 19 Feb 2026 17:36:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Abin Joseph <abin.joseph@amd.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, git@amd.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: xlnx,axi-dma: Convert bindings
 into yaml
Message-ID: <aZeQeVPU6VhFr8hV@lizhi-Precision-Tower-5810>
References: <20260219152621.2375256-1-abin.joseph@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219152621.2375256-1-abin.joseph@amd.com>
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB12065:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e5e7e7-c00f-4094-280e-08de70075f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c34a7mW8BbUdkDLN3yHgsNA9ZDQXFt3emsc/4ZwZzrPtEdmtdMDLb6eLqdCE?=
 =?us-ascii?Q?qeOj7OOGqZbroQavhFsHLa/bNxxOq4h2Cgy8UK1Cbo6DuUVgNoVRbOdhCSPd?=
 =?us-ascii?Q?NYrOyhyD0whsUimycKCfOT0JuoDX5OAgw4DQmYdIoiB7hbsEQ4GP/gqSBSe8?=
 =?us-ascii?Q?vaXJ73m/1upU2Vjj2+bLFbqAokZIhAqW0IlTvzSb0OJaVSehMHapPO1Fs9gj?=
 =?us-ascii?Q?Ydy8jCoXG5nUPgnDq8v1fTSpG6AngRx4Dzucwmzsw9qAA1phiz7zMPUurUPd?=
 =?us-ascii?Q?cK9ZlyeBWH6Ro5QGIO9TNyRHZvTEgYmhRJee64DpNPKKiK3sU1xDUpnnLRiB?=
 =?us-ascii?Q?clGcIws0qxZNuAWXopZC4GC1HEJmY0v/H8WWi9jnHctJNynD2/QevJULyXs2?=
 =?us-ascii?Q?/vurWuzSZ6rJk+120yosymro9Xc4AGxs8K0lOjf3VVJB4TS0rtbFtgEHFvvC?=
 =?us-ascii?Q?daDamTfhK5OgJB3OiTF9m/auRrg8PgrUuOBEARBAmCVo70UAjVSW5V0g61g5?=
 =?us-ascii?Q?pETSr1VHXmlzg+e5wPHoTDS5d3/pytKvcXK8SyH6iLy3NyN2oTx0hrCFfIZU?=
 =?us-ascii?Q?FsYbStBMrjscGIss0xDYtbqepWLx4cBobiDdIwNQBypK42HPuzEY7+nuiZiW?=
 =?us-ascii?Q?4InTBMxE0BjoGQyKC0j6mrJJ6IhnJFeBdMh2rqxklAFqZLJ+vyPAmlRPqydL?=
 =?us-ascii?Q?N1bHjOHOpRaIt49vh83GTuDr91t/TsZUMt+FeBAEjiydjhNyYtcBIwR0q5CQ?=
 =?us-ascii?Q?lV7keoQkXJ2O/OJwfRaeZ+WMmLXKVtbzH5ZPhTmPutuL8qNJwQrbyVFalmGD?=
 =?us-ascii?Q?4t2oWXQX1/6WrFI7A23Qfu/5xRAqqgOH63J6LsFhC0Z1V16Nedo713uox5ZE?=
 =?us-ascii?Q?T7Zrbss1RBNEhGZt8aZL7vlPQZu1duKkWl2l9IDpcIj2va7cDoI/ARIkb3aA?=
 =?us-ascii?Q?e6hhX7XEZyd4k+K0gAAYRWJTzvqZWR2YKb+J4EpSC4/MXpUFTrCHjo1cyiD1?=
 =?us-ascii?Q?C0XoKwJy0XHDrkRIOt+YRZt7MT82v/A0sLxrg7lMDPsvMnxs+nwGlqqedb67?=
 =?us-ascii?Q?bczfcc3Oa05j+EYdKvIxT7LCmTFMcn8zWfA4os6lBFjsmlDNtmqKzgxK/rir?=
 =?us-ascii?Q?HA6ORw9B+ZTpmR8/kc0VVHZqgylMkU/NruItcd6VxmlaYY/lEQ1g26jRfgJx?=
 =?us-ascii?Q?JqCIABczBjcPbS62sXOKuoIROL3184eEtvWjymsD6b/Xm4KgcOMtdpx5RzYw?=
 =?us-ascii?Q?vky6jrP/HnbhhaZY/pMjFZItFFLLLWB4e35ClZUj8a8Bjc98VlKdqJQq2XaA?=
 =?us-ascii?Q?xPAnTLHCmlOYgu8RSG+SDOMpHinwlW1GkguSgDAd0ZhQvgrjSP+xtjTjph4E?=
 =?us-ascii?Q?bjlw5pAbPwz8BDS2dORzL+c2TAqpHQ1KylqxFT112FNCrgh8aoSj03M/kz5P?=
 =?us-ascii?Q?kucfFcXa5L6jC8Myo40PH6WdhsT/uYHbeOO6xj/zWfpDQ5+djnZrFxW6U7EE?=
 =?us-ascii?Q?W95HUsclEdj/W0hN8QWjL/T+zL3IxjotZar6r6o98kh2zW64iFKw+DcOiLqa?=
 =?us-ascii?Q?Tg7eYU/djcamn7k70toUV1RK5+63l6XbcBEUjq0vFMar1xhUzB748FfdxN5C?=
 =?us-ascii?Q?1qcIpSoEsbPbuX2cN7cNluk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UczstJ4EBrYglQFmxPSV1FHkpkSOhTAdup8tMNsCTPBhgMjtAiKi/xNq0b7?=
 =?us-ascii?Q?xk3sAQfoiWtnaQrcybDdjFiOTwK6+NcmdZ0b4Cj/gjruZgoT+/WDrya1F28e?=
 =?us-ascii?Q?qrDJ75JQ+rgwfEo28poCcCq07bM7Lb2s5kLbJ9ahQjhoJ9mp5j2EJyr8iu9O?=
 =?us-ascii?Q?oSNyZ/Tk/IjCskTPhqPjDfZk6Zzp6MwjmdeoWtrRXOSX1Yco0Nc7ntAcnUnf?=
 =?us-ascii?Q?QQxOSN6/G0QJrh/OVPhsFDcLMpz0sFxB5b6d00+eSoaNusKapWExzjGYje2H?=
 =?us-ascii?Q?YFY3PoivGIWnp1TAXn9aoVfcJCHOL3tcPs+9+HhZTYMhLV7cF3Xhoic84ed4?=
 =?us-ascii?Q?mqzB8axhr7SD4JSLztxCn/8ooTjl3RR+JxknWmhIlLHsCyxMy5iScl5grUc/?=
 =?us-ascii?Q?GxfbR1TozETODmemK1h6tGfT9eeY2Q/KVNBnp3ZTubvtTjZBGvArl8D6a87G?=
 =?us-ascii?Q?a6m2ENT/0Ng5jTMsZCUMq7Mwi310oGUJOB/tI2QeE5qQ8VTHzpF82fzPmZrB?=
 =?us-ascii?Q?tRgBGVw8Wdc6kRJPL1VOcsg0yoJb58T+QRSRzAx/pyERRad2BiATHopCKcZH?=
 =?us-ascii?Q?xS+5khOv7ja88w3NKpJ+sSQBwefjwZUd+8QDz7bQ3btPILYcgQTZ9irEokAX?=
 =?us-ascii?Q?ImVjVD/BXtUJrP4UdAihIA/XTTkl/29EEtTTLrjmDvpAN9sBoPFs40cnEOKU?=
 =?us-ascii?Q?ZiQAiJIenzoNq5PJep4UuHsNxXPKw0PRxngCQ9fPMpqGvs8Qral1AefC6yP8?=
 =?us-ascii?Q?6H/gKABFPRPE9gUSS0Y0EaDbNZbm6c6M4ANDgziWdiRTv9lp9ab4eXHdqrD1?=
 =?us-ascii?Q?Y2dECboSNRQCqaOxBVxW/96gyfuDOXJ73FBwhBT29HldXnBwdPtrDOHzlwok?=
 =?us-ascii?Q?aiN0yeibh/y8JNOrj1+PnzDw3qkmTjvFAjmsNawKNXG+27xX5Xd0HE14JRic?=
 =?us-ascii?Q?oqm1yxoafH0ZmbZpckSSZLkAAK9pzBS/1YITezvDSha0YeuS0wjUy4uJkaXh?=
 =?us-ascii?Q?PhT/iDKkQ7fkAg2+/UuQwKTeKG0PQw3LeH5NEv9uk4+i1L5kJPQdOWz0dbcp?=
 =?us-ascii?Q?7c33MZPZctBS0jqI5RV0mfPl74GDoPqQnBTymqcGA1qHAiHHUm1WnkbGG0BY?=
 =?us-ascii?Q?A4DcQy+qg4XKGkoCZ0cm9v2IwmkMp3n3RnLCDC6gSH9yLG1aCx4teN+VIbGF?=
 =?us-ascii?Q?XLJzAW5all878y5Uv42Z0Ll94cxaZdODdhtAv+X1Uz9ZqxwCUH3qrUkFKSlA?=
 =?us-ascii?Q?brHH2guHaBtuEiud+iu5ctSiQd6wBEtt0J/c672yer6+1tZ8qhEp2XJS53P+?=
 =?us-ascii?Q?SZwhQlNIXDyxkQQ0IpplLxACeu6I8Emc4LtleoMWDHrxWfmsyi00e828NCP4?=
 =?us-ascii?Q?pwaX72lxPgxG81+LvzXeK30lKbNvrnbN1mYenryoZLlHVmxTfTNrSqWNkr1D?=
 =?us-ascii?Q?PtejyM/7oraP68N7aZnbFwBN5j4x7EeSbR+kLvdwjqbn4EK6O8IfW7YAb6Wa?=
 =?us-ascii?Q?184p+HWm8xn6mpziQZ/gfMuV5t3JVLvrjELOT4ljyJln/NMfsQquiWg2fVFp?=
 =?us-ascii?Q?9x4+Ce6umjjMoy7AQHrF/auo+2nit8IOiQKw5Yaehqzv62Sn92zJIXrttKD6?=
 =?us-ascii?Q?U7ofVlVVjrCTPchvIRxacW7exUMTSB2ANIJ0MiRUxpCEYv6cAGaeYcFzWvAi?=
 =?us-ascii?Q?KBAGm/5WqD6wJAwAC4K47Dx4dwaIJfcFL0NG2F6TlcPM/1mo2K8WITBOFPrk?=
 =?us-ascii?Q?T0z0x39WzA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e5e7e7-c00f-4094-280e-08de70075f9d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 22:36:50.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0HnWLnqK/3/xcsGXEKzYsB3yC+G6Y+o0y1wVqHroVigl5GKUFq4mVsfaSxPSNLs+/KPoJnJGUxB9+jJMVT+fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8981-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[2.98.207.48:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F8A2163393
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 08:56:21PM +0530, Abin Joseph wrote:
> Convert the bindings document for Xilinx DMA from txt to yaml.
> No changes to existing binding description.
>
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
>  .../bindings/dma/xilinx/xilinx_dma.txt        | 111 -------
>  .../bindings/dma/xilinx/xlnx,axi-dma.yaml     | 290 ++++++++++++++++++
>  2 files changed, 290 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml

yaml file need use one of your compatible string

>
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> deleted file mode 100644
> index b567107270cb..000000000000
...
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Interrupt lines for the DMA controller. Only used when xlnx,axistream-connected
> +      is present (DMA connected to AXI Stream IP). One interrupt for single channel
> +      (MM2S or S2MM), two interrupts for dual channel configuration.
> +      When child dma-channel nodes are present, interrupts are specified in the
> +      child nodes instead.

interrupts
  items:
    - description: for single channel
    - description: for dual channel
  minItems: 1

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 5
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 5
> +
> +  dma-ranges: true
> +
> +  xlnx,addrwidth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [32, 64]
> +    description: The DMA addressing size in bits.
> +
> +  xlnx,num-fstores:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 32
> +    description: Should be the number of framebuffers as configured in h/w.
> +
> +  xlnx,flush-fsync:
> +    type: boolean
> +    description: Tells which channel to Flush on Frame sync.
> +
> +  xlnx,sg-length-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 8
> +    maximum: 26
> +    default: 23
> +    description:
> +      Should be set to the width in bits of the length register as configured
> +      in h/w. Takes values {8...26}. If the property is missing or invalid then
> +      the default value 23 is used. This is the maximum value that is supported
> +      by all IP versions.
> +
> +  xlnx,irq-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 255
> +    description:
> +      Tells the interrupt delay timeout value. Valid range is from 0-255.
> +      Setting this value to zero disables the delay timer interrupt.
> +      1 timeout interval = 125 * clock period of SG clock.
> +
> +  xlnx,axistream-connected:
> +    type: boolean
> +    description: Tells whether DMA is connected to AXI stream IP.
> +
> +# Note: This schema combines all DMA types in one file. Parent-child channel
> +# compatibility is enforced via allOf conditionals below. Alternatively, this
> +# could be split into separate schemas per DMA type to simplify validation rules.
> +patternProperties:
> +  "^dma-channel(-mm2s|-s2mm)?$":
> +    type: object
> +    description:
> +      Should have at least one channel and can have up to two channels per
> +      device. This node specifies the properties of each DMA channel.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - xlnx,axi-vdma-mm2s-channel
> +          - xlnx,axi-vdma-s2mm-channel
> +          - xlnx,axi-cdma-channel
> +          - xlnx,axi-dma-mm2s-channel
> +          - xlnx,axi-dma-s2mm-channel
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      xlnx,datawidth:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [32, 64, 128, 256, 512, 1024]
> +        description: Should contain the stream data width, take values {32,64...1024}.
> +
> +      xlnx,include-dre:
> +        type: boolean
> +        description: Tells hardware is configured for Data Realignment Engine.
> +
> +      xlnx,genlock-mode:
> +        type: boolean
> +        description: Tells Genlock synchronization is enabled/disabled in hardware.
> +
> +      xlnx,enable-vert-flip:
> +        type: boolean
> +        description:
> +          Tells vertical flip is enabled/disabled in hardware(S2MM path).
> +
> +      dma-channels:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Number of dma channels in child node.
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - xlnx,datawidth
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: xlnx,axi-vdma-1.00.a
> +    then:
> +      properties:
> +        clock-names:
> +          contains:
> +            const: s_axi_lite_aclk
> +          items:
> +            enum:
> +              - s_axi_lite_aclk
> +              - m_axi_mm2s_aclk
> +              - m_axi_s2mm_aclk
> +              - m_axis_mm2s_aclk
> +              - s_axis_s2mm_aclk
> +          minItems: 1
> +          maxItems: 5
> +      patternProperties:
> +        "^dma-channel(-mm2s|-s2mm)?$":
> +          properties:
> +            compatible:
> +              enum:
> +                - xlnx,axi-vdma-mm2s-channel
> +                - xlnx,axi-vdma-s2mm-channel
> +      required:
> +        - xlnx,num-fstores
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: xlnx,axi-cdma-1.00.a
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: s_axi_lite_aclk
> +            - const: m_axi_aclk
> +      patternProperties:
> +        "^dma-channel(-mm2s|-s2mm)?$":
> +          properties:
> +            compatible:
> +              enum:
> +                - xlnx,axi-cdma-channel
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: xlnx,axi-dma-1.00.a
> +              - const: xlnx,axi-mcdma-1.00.a
> +    then:
> +      properties:
> +        clock-names:
> +          contains:
> +            const: s_axi_lite_aclk
> +          items:
> +            enum:
> +              - s_axi_lite_aclk
> +              - m_axi_mm2s_aclk
> +              - m_axi_s2mm_aclk
> +              - m_axi_sg_aclk
> +          minItems: 1
> +          maxItems: 4
> +      patternProperties:
> +        "^dma-channel(-mm2s|-s2mm)?(@[0-9a-f]+)?$":
> +          properties:
> +            compatible:
> +              enum:
> +                - xlnx,axi-dma-mm2s-channel
> +                - xlnx,axi-dma-s2mm-channel
> +
> +  - if:
> +      anyOf:
> +        - properties:
> +            compatible:
> +              contains:
> +                anyOf:
> +                  - const: xlnx,axi-cdma-1.00.a
> +                  - const: xlnx,axi-mcdma-1.00.a
> +                  - const: xlnx,axi-dma-1.00.a
> +    then:
> +      properties:
> +        interrupts: false
> +
> +required:
> +  - "#dma-cells"
> +  - reg
> +  - xlnx,addrwidth
> +  - dma-ranges
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false

need ref dma-controller.yaml

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    axi_vdma_0: dma@40030000 {

Needn't label axi_vdma_0

> +        compatible = "xlnx,axi-vdma-1.00.a";
> +        #dma-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x40030000 0x10000>;
> +        dma-ranges = <0x0 0x0 0x40000000>;
> +        xlnx,num-fstores = <8>;
> +        xlnx,flush-fsync;
> +        xlnx,addrwidth = <32>;
> +        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
> +        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
> +                      "m_axi_s2mm_aclk", "m_axis_mm2s_aclk",
> +                      "s_axis_s2mm_aclk";
> +
> +        dma-channel-mm2s {
> +            compatible = "xlnx,axi-vdma-mm2s-channel";
> +            interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +            xlnx,datawidth = <64>;
> +        };
> +
> +        dma-channel-s2mm {
> +            compatible = "xlnx,axi-vdma-s2mm-channel";
> +            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +            xlnx,datawidth = <64>;
> +        };
> +    };
> --
> 2.25.1
>

