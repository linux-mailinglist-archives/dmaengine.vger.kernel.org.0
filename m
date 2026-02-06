Return-Path: <dmaengine+bounces-8808-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIH0F4lFhmkVLgQAu9opvQ
	(envelope-from <dmaengine+bounces-8808-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:48:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F97102E3A
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7043C302305F
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267653043D7;
	Fri,  6 Feb 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHzKFEaT"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B21E991B;
	Fri,  6 Feb 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407302; cv=fail; b=kTK3/syimGI5DsMO5N4fyYQSDaB8WZcO6RUXk2IVhdrm3b1wo/v5OyivFUzXW53XF6fVnFJqDUe0FDLL9c/CiRg04qjVHFV6keE5TPUjvcEw27DN5gPu+HUslqOZIdSPQFU52LQcMobfLkEYJMOr02n4yeGZ1ZayFOTXmJMVmOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407302; c=relaxed/simple;
	bh=sy8JDhA80ImklgBqV/1mOqIYeRbzu6PMOIbCR2KlqBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CfC2ajTEHNE2frVmoB/ltPFNwWCEIPCrn2T0kjX9u75uvaWAHlrgDJHrfgwyxuTEcQRMZD4DFmLyZ116URnZBbhdDIl9IucbgoZIAf1iitqLjiMYEATFE8Yw+fTWQvVeFHOaONKg8HiyBNKACiA/Pib80WiKYeYTvbE02De3fX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lHzKFEaT; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpL3An3uqH6aD2uQ9eez+y8guWdBTYO7idO4UEkugQAEllYInVEVnLHBoWnBoRG9JRq6Idnd/Pg83Zh6GoEtkfbibLGdCWXbt0YhcO3AcqE9b6SMNIeTTeBVWBUYmhNQ55oZfGf7ikdtHnOtQe1wyfObni1NifBHk6QxJ5EhcoBOFu4sKyRv4vuoyUKz8JRpD65vqkPgWF3SacRQlzyTe0XGfofhMrg/8nVdkxOocQUXW+RH6mRYzfD/f274x4dch8sLKLg4yhO6pUNkqT+EizrDZYSnqaUaaAXdPXfVvAbeo3Xe5gIuLBSh/8uzh0ff5Bi2jQMP3TFWKPcd7ZeCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGPQsh4KYxOA4xqx9njarnGZroPCYGkN726rzC38whQ=;
 b=BC0bXeK1NBPstZpI2+kAPT0X/who7Z0mgihKk8iCG5BEC7eKqwyAlJ37tjryQwopK+vt5lJarbbO6KF8L7g6O9zZPMVYE9C2b2pawhcs7Lg1Hp4obQRiS+vUTYGNDMKdHFXHyLwMwn11ykKCkjjV4PRBtU//Uu3evnIfBzbqxvKUN5W6SdqJJVPO5TW70RiAbhiuOF1U/qwZdsBi+8TQh5yKjs4lVUXKT2hNDGtQ03OtoGS3CR9N60KVzFIwJb7ixgspbvLr7yxskrM5bY3QeA392rATvvLtsl86lVxC+ujGJ+gaB7zl+X0ELGukWF3ox4rKBbWdM+G3j1hYnfmF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGPQsh4KYxOA4xqx9njarnGZroPCYGkN726rzC38whQ=;
 b=lHzKFEaT1RExXhd7zIkFlwGnCYlLBNg5pT+FQuVLi+650mqIXyMuwuEmDUNZyV6LR2NwVx4edgSUE1KgxLLICVr3hyYSI3AvJP6dAhzp3q+cAdObbK9kQ8Ey2X5Zi/dLoM5bJgx0F2nXAkIUI8wQ8f2EArXgrjNeHY5C/Zz2hawIrRm1xyLls22z2RfD9OBaireo4qSpN96IIHJiU1pbBKO5Yg2GcNWnyT3DwWDZzuEd9C+JkW5FYX/7MuGZCfMAcA0KCQhpYbpijNEp1GaZByEdHzc8DwjnsScqm20ThilVud+JWwGJ0MW6EYOwku50xnetHw3rcfInNrH1b9cyZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8601.eurprd04.prod.outlook.com (2603:10a6:20b:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 19:48:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 19:48:18 +0000
Date: Fri, 6 Feb 2026 14:48:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dma: amlogic: Add general DMA driver for A9
Message-ID: <aYZFeZXAaxCEPy8w@lizhi-Precision-Tower-5810>
References: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com>
 <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-amlogic-dma-v3-2-56fb9f59ed22@amlogic.com>
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 193a3893-c16c-4a72-4632-08de65b8ac93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ra6pcgz5tMTWVjK/9NgqwmZV9haXv6U5Ruv6ZEo/lIiqYp53/JK1JKDzpYbO?=
 =?us-ascii?Q?tx4siBTfuCnn9Uv8JnlTBxWrp8i00Aj3yTQIrHeTkCXhctTXfwh6ooE7VyNG?=
 =?us-ascii?Q?7XKl0T/1cjj+npSmy6PU2K7+9fB0U9zdDEVl/7t31LWZTWG9xtfMtrO5MJJX?=
 =?us-ascii?Q?QBUFbfvGVomO88aEV+j+sVamPh8NUOxNx90hEuxohCmcWRf24sjBmp6awpBT?=
 =?us-ascii?Q?yIY0m+6UXnWi6IQ/govGCLYKjbmBTEwhT3W5Nj9HcvmYVf63GwaBR3A1BdbM?=
 =?us-ascii?Q?nMEI7WXpYkjxL651YBLEDLHDkhyp12YcRn/XcllLTkxQtl1al0/QWa1Wf3Ke?=
 =?us-ascii?Q?qVAGELBo2Y3XHx3A8nTVkC+Xnu7icwhsepgu49nFm/6l1tkk/Be3FCc6cVfO?=
 =?us-ascii?Q?FYzVbconnbE/ap6SnJpmGDJBN5u65qGvcaWPIfp+ZDr6Ji1iMtaAL9+BKWNA?=
 =?us-ascii?Q?yyIwmxZiy5DaavPGgnhiWr2G90QqQjmX1uAJR9oG2JDR6Gm7KWZe2jsofwF7?=
 =?us-ascii?Q?IKM0nh0KK7XJJmSIwNs/hCISrVxq3Vpt2szKWAzwAU1m5L9PIVMSQeYkYeio?=
 =?us-ascii?Q?Qu6TdpyXusVZiIk4IhtSnBRWRm7SFdcdsXOLwDapaqtt6oH3KLaHoaaCBImd?=
 =?us-ascii?Q?shMEu+AjZc2USSpOUOA6VmP8xbaEoB2U0OO4uA2GVrvM66sJfUVfRRi6FxUy?=
 =?us-ascii?Q?FvQV13y5godKi84wLJaHREls8LNdE705QPd3L9uooInS9127rOPikf9xGl/S?=
 =?us-ascii?Q?H8aKpUlLgycLB5wr6PePjAYk1uglpBAze9r7h0ORCgGsYvRsKgfCc9SJR+LP?=
 =?us-ascii?Q?m4SOW8SzylsDPsqNJsvpL1xSpCVhi7JlYUOmssFtz2lK8y0PTt+vA6C0l1fD?=
 =?us-ascii?Q?R06faDSsWlCM2PUGRFDSh0FZyfWMPAiuXKVzUbt/MAxakoHh5zXDfgUCijvN?=
 =?us-ascii?Q?0P5cFEMmA8daSe4UwJjU/T5xgMl7oQXkEpYMRcWi+xkI1gGLGwRje/3ZUYN7?=
 =?us-ascii?Q?TAJxLI75NBC8lS3s3Q/4pUikR5Wz0bfnOSkAZjuZmIKuu8Snri7rVHxPUH1h?=
 =?us-ascii?Q?e2+jpE3wJv8EFICmlQ37d9ojIRDNA9kD1uhBn3DWrp/AkOUk1heRo3SrHQhn?=
 =?us-ascii?Q?z5bUKDj5sXv9O9ut09IWdzZ7OC+p5YARGO1OWA5MBxGV3O3UrviYcjmwNosy?=
 =?us-ascii?Q?Yo2vK19aESS/DaVLFbnUrQipoMuY4dssgLNSovGqwemJRsHf/qsd2kfo4b4r?=
 =?us-ascii?Q?2fcPYSJQcjXz503EQ4ifcFX6Aap3G1nC1D1SKY0naFxib9ZshQaaDHx9/OdM?=
 =?us-ascii?Q?SN1BEXi6E64ZwSgGYdMa2mAf6RoajyFu2Ksgj6O2QNyH6Rj2IS31vMhzjUwT?=
 =?us-ascii?Q?VaoVTyv4Jv99uI9HsC9rBIknQNZS+2qvNRzCg86BZIp5t4KbIsuneytMBuZi?=
 =?us-ascii?Q?llNqcywOY8NbnPZj7CUmuV36JEhJtr4ShratvoUZiOBmPqsXyBI0w0GG2+7s?=
 =?us-ascii?Q?d15uIMBRZEoObwLvlszJcsJ1PNXJItbzIwkujh/Vi9R1tfqXPlKKcUdL5Qkj?=
 =?us-ascii?Q?tjSAwx+mQ3B/4+6PFAIyG52Ec/F23eXbBRHMELRnKV7yxnAamexkPFBZGnJ0?=
 =?us-ascii?Q?fAWYEddgh577LXL4aKvYzGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LI9AzfZQuOsI4tnxqo7nGN/kTMNQ/bP/SNJHpC6kWRewXH2K6UXW1AG6eyIx?=
 =?us-ascii?Q?X6sLm4xabH7Pfm07BnE9cWQ2fIsLgNm6lj6RB0P8s1X9bOJS7BlBRglyeCkq?=
 =?us-ascii?Q?B+8XYNjHuA2t3R59zf7vGrOWaYmMESPBKaItS/315sAtvbCJOrjPOvUeKBoB?=
 =?us-ascii?Q?IZ6YvcC1gDiHOYx/RweSOiftUSZ5J6IdsVHWE/As900GRQg654Njwzdk40HA?=
 =?us-ascii?Q?FC7zoleBs2nNeK6LqLVx5R8JJpPVZ8yXS99UczqRKcyFAheFTNDLRplM7iUP?=
 =?us-ascii?Q?h5komGEijLDFDAh4EAYl15vQlelQeVoacF2tle3hA9IFFCVb+i9j5Y6l4nyn?=
 =?us-ascii?Q?TRpiqqY299y4a0xj9/ZWxyTded7R47IZF9jQbwTPdzN804NANBI0vufWCSTl?=
 =?us-ascii?Q?KV102ecSq4ulBcpbrENfitcg5ZC9W7UCxvawDgbQWzaAhpJhTLY6hf1+FrIv?=
 =?us-ascii?Q?v55DHk8bEeKHJyX9NEuXiOt9+o02dnq6TUINmJQggdf0bf1ITHRl1t+um0UE?=
 =?us-ascii?Q?+skgi6Nk/97q9tXo5MicXSVexgiDBheZD93RdXP+glLJtHrQi3Mlc1ECYLBB?=
 =?us-ascii?Q?hUpQNDoABdI1KckmlW9jxkmMYXUNCwYFvjC0ctkG8KPN8voz9K9d1eP3HMlm?=
 =?us-ascii?Q?RaDHSecmZZU86JC+Fk3taDMckSwfBRpw8oienMWsfo8IRPvLoGkjvMrUJx8M?=
 =?us-ascii?Q?QnVFUVtnt9j7SJqEycEN2k6LEAQQEdpil1vMErk4Y/L+U1ZZY3AF6E7XZrtF?=
 =?us-ascii?Q?Y9Sfr2uy8OZk19N7EHo/LbfATFIIHoiDt1h/BBQoNZ/9C8Wcfz8frc0IArR9?=
 =?us-ascii?Q?ulp6bHSbhrNJDM/i5BjQS4+dMorWOcqTAxEyWOsHIppqAP/aCC/lkKkVWiOT?=
 =?us-ascii?Q?Fl6eLAL1wP4JDEspFWUotqm74LXMtsP3oUF4Kknf54lNSaIlt4Zqe5gyIfma?=
 =?us-ascii?Q?/Id6JI6/Y/0F3PoZPvvf7L9qJAKwclHWbhTa47t15hefzuua4hR9PnFYg80F?=
 =?us-ascii?Q?PWVvBS/WImmmUtIbhNCApMQoGHsatBzKwWm5yJfLTCDrj+QaAQeATyseTFe4?=
 =?us-ascii?Q?T5XnIA+3VrRznqm0NBOJjB+pkGDrcrJ1ZFZEt+ivfmq1nLt3/R39BFEE/WBU?=
 =?us-ascii?Q?b6tzFS989evnRq6GltpVGAloGx3aM9oW4oac5K5uehT9mHx2q0nlxHTWeOi6?=
 =?us-ascii?Q?koOG2gylAB4y0OwI5PrSJ8m3KQxpk1mP9KpalUJKvKem/5FfAD18HFL54+BW?=
 =?us-ascii?Q?L9/fU1hkflT/wYExwqn3ZOO2O/MDKQeuBDZCQpUcopxIFWojrK2QeewWYnpA?=
 =?us-ascii?Q?TeoVUhUfb+dXPHfUhyihc3HaScmOHrbG0FITlaTMGoSzSmS1RtIJaWJ2ur/8?=
 =?us-ascii?Q?Hi8lE3xJLf7tLvGvihkB0dUazuBtf1WhyKgmEqJQfvCcQ/nFjbHntsIhJNoA?=
 =?us-ascii?Q?BDsRH2Zfxm7ZeTMw31mm79cpCwTllDl+Q2NvuNzBoNuxKcs9bf4wbmSZuA+s?=
 =?us-ascii?Q?XKmf7aQj+IGFPaeI00hpb4MxTpT7tyKprH6dLaHaBYtHp99KxLroSh5nOb8M?=
 =?us-ascii?Q?kKc8ET65g1wZjdf8/m8qYO2Jtq2IE1G7zGW0JmeJJqf8eyTpqz7jD6U3914m?=
 =?us-ascii?Q?Ia7NYNWUrXy6p/ZTJkN/4YRCxK+NiXJr5WCyjl5u/L3vSI9KKu1NSzQsgT4u?=
 =?us-ascii?Q?C34QXIa+nWZGw+eNpQJ/WItohIOEISUSKVCQFl2HDimF0UdmQLo60FWRo/hu?=
 =?us-ascii?Q?/Jm5Q/QaiA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193a3893-c16c-4a72-4632-08de65b8ac93
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:48:18.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZmnbYNZ0ZipRfDi+Kk5LdzqPPSJtYRpjuJnPbtAHxiQuVdlx17qQm2NyRMgWZMHBqjmH+e6s8DwYHuOMxePCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8601
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8808-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.951];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B6F97102E3A
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 09:02:33AM +0000, Xianwei Zhao wrote:
> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> is associated with a dedicated DMA channel in hardware.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/dma/Kconfig       |   9 +
>  drivers/dma/Makefile      |   1 +
>  drivers/dma/amlogic-dma.c | 561 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 571 insertions(+)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 66cda7cc9f7a..8d4578513acf 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -85,6 +85,15 @@ config AMCC_PPC440SPE_ADMA
>  	help
>  	  Enable support for the AMCC PPC440SPe RAID engines.
>
> +config AMLOGIC_DMA
> +	tristate "Amlogic general DMA support"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	select DMA_ENGINE
> +	select REGMAP_MMIO
> +	help
> +	  Enable support for the Amlogic general DMA engines. THis DMA
> +	  controller is used some Amlogic SoCs, such as A9.
> +
>  config APPLE_ADMAC
>  	tristate "Apple ADMAC support"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..fc28dade5b69 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
>  obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
>  obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
> +obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
>  obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
>  obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
>  obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
> diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
> new file mode 100644
> index 000000000000..cbecbde7857b
> --- /dev/null
> +++ b/drivers/dma/amlogic-dma.c
> @@ -0,0 +1,561 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
> + * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
> + */
> +
> +#include <asm/irq.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "dmaengine.h"
> +
> +#define RCH_REG_BASE		0x0
> +#define WCH_REG_BASE		0x2000
> +/*
> + * Each rch (read from memory) REG offset  Rch_offset 0x0 each channel total 0x40
> + * rch addr = DMA_base + Rch_offset+ chan_id * 0x40 + reg_offset
> + */
> +#define RCH_READY		0x0
> +#define RCH_STATUS		0x4
> +#define RCH_CFG			0x8
> +#define CFG_CLEAR		BIT(25)
> +#define CFG_PAUSE		BIT(26)
> +#define CFG_ENABLE		BIT(27)
> +#define CFG_DONE		BIT(28)
> +#define RCH_ADDR		0xc
> +#define RCH_LEN			0x10
> +#define RCH_RD_LEN		0x14
> +#define RCH_PRT			0x18
> +#define RCH_SYCN_STAT		0x1c
> +#define RCH_ADDR_LOW		0x20
> +#define RCH_ADDR_HIGH		0x24
> +/* if work on 64, it work with RCH_PRT */
> +#define RCH_PTR_HIGH		0x28
> +
> +/*
> + * Each wch (write to memory) REG offset  Wch_offset 0x2000 each channel total 0x40
> + * wch addr = DMA_base + Wch_offset+ chan_id * 0x40 + reg_offset
> + */
> +#define WCH_READY		0x0
> +#define WCH_TOTAL_LEN		0x4
> +#define WCH_CFG			0x8
> +#define WCH_ADDR		0xc
> +#define WCH_LEN			0x10
> +#define WCH_RD_LEN		0x14
> +#define WCH_PRT			0x18
> +#define WCH_CMD_CNT		0x1c
> +#define WCH_ADDR_LOW		0x20
> +#define WCH_ADDR_HIGH		0x24
> +/* if work on 64, it work with RCH_PRT */
> +#define WCH_PTR_HIGH		0x28
> +
> +/* DMA controller reg */
> +#define RCH_INT_MASK		0x1000
> +#define WCH_INT_MASK		0x1004
> +#define CLEAR_W_BATCH		0x1014
> +#define CLEAR_RCH		0x1024
> +#define CLEAR_WCH		0x1028
> +#define RCH_ACTIVE		0x1038
> +#define WCH_ACTIVE		0x103c
> +#define RCH_DONE		0x104c
> +#define WCH_DONE		0x1050
> +#define RCH_ERR			0x1060
> +#define RCH_LEN_ERR		0x1064
> +#define WCH_ERR			0x1068
> +#define DMA_BATCH_END		0x1078
> +#define WCH_EOC_DONE		0x1088
> +#define WDMA_RESP_ERR		0x1098
> +#define UPT_PKT_SYNC		0x10a8
> +#define RCHN_CFG		0x10ac
> +#define WCHN_CFG		0x10b0
> +#define MEM_PD_CFG		0x10b4
> +#define MEM_BUS_CFG		0x10b8
> +#define DMA_GMV_CFG		0x10bc
> +#define DMA_GMR_CFG		0x10c0
> +
> +#define AML_DMA_TYPE_TX		0
> +#define AML_DMA_TYPE_RX		1
> +#define DMA_MAX_LINK		8
> +#define MAX_CHAN_ID		32
> +#define SG_MAX_LEN		GENMASK(26, 0)
> +
> +struct aml_dma_sg_link {
> +#define LINK_LEN		GENMASK(26, 0)
> +#define LINK_IRQ		BIT(27)
> +#define LINK_EOC		BIT(28)
> +#define LINK_LOOP		BIT(29)
> +#define LINK_ERR		BIT(30)
> +#define LINK_OWNER		BIT(31)
> +	u32 ctl;
> +	u64 address;
> +	u32 revered;
> +} __packed;
> +
> +struct aml_dma_chan {
> +	struct dma_chan			chan;
> +	struct dma_async_tx_descriptor	desc;
> +	struct aml_dma_dev		*aml_dma;
> +	struct aml_dma_sg_link		*sg_link;
> +	dma_addr_t			sg_link_phys;
> +	int				sg_link_cnt;
> +	int				data_len;
> +	enum dma_status			pre_status;
> +	enum dma_status			status;
> +	enum dma_transfer_direction	direction;
> +	int				chan_id;
> +	/* reg_base (direction + chan_id) */
> +	int				reg_offs;
> +};
> +
> +struct aml_dma_dev {
> +	struct dma_device		dma_device;
> +	void __iomem			*base;
> +	struct regmap			*regmap;
> +	struct clk			*clk;
> +	int				irq;
> +	struct platform_device		*pdev;
> +	struct aml_dma_chan		*aml_rch[MAX_CHAN_ID];
> +	struct aml_dma_chan		*aml_wch[MAX_CHAN_ID];
> +	unsigned int			chan_nr;
> +	unsigned int			chan_used;
> +	struct aml_dma_chan		aml_chans[]__counted_by(chan_nr);
> +};
> +
> +static struct aml_dma_chan *to_aml_dma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct aml_dma_chan, chan);
> +}
> +
> +static dma_cookie_t aml_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	return dma_cookie_assign(tx);
> +}
> +
> +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	size_t size = size_mul(sizeof(struct aml_dma_sg_link), DMA_MAX_LINK);
> +
> +	aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev, size,
> +					       &aml_chan->sg_link_phys, GFP_KERNEL);
> +	if (!aml_chan->sg_link)
> +		return  -ENOMEM;
> +
> +	/* offset is the same RCH_CFG and WCH_CFG */
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> +	aml_chan->status = DMA_COMPLETE;
> +	dma_async_tx_descriptor_init(&aml_chan->desc, chan);
> +	aml_chan->desc.tx_submit = aml_dma_tx_submit;
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
> +
> +	return 0;
> +}
> +
> +static void aml_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	aml_chan->status = DMA_COMPLETE;
> +	dma_free_coherent(aml_dma->dma_device.dev,
> +			  sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
> +			  aml_chan->sg_link, aml_chan->sg_link_phys);
> +}
> +
> +/* DMA transfer state  update how many data reside it */
> +static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	u32 residue, done;
> +
> +	regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
> +	residue = aml_chan->data_len - done;
> +	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
> +			 residue);
> +
> +	return aml_chan->status;
> +}
> +
> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	struct aml_dma_sg_link *sg_link;
> +	struct scatterlist *sg;
> +	int idx = 0;
> +	u32 reg, chan_id;
> +	u32 i;
> +
> +	if (aml_chan->direction != direction) {
> +		dev_err(aml_dma->dma_device.dev, "direction not support\n");
> +		return NULL;
> +	}
> +
> +	switch (aml_chan->status) {
> +	case DMA_IN_PROGRESS:
> +		dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
> +		return NULL;
> +
> +	case DMA_COMPLETE:
> +		aml_chan->data_len = 0;
> +		chan_id = aml_chan->chan_id;
> +		reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
> +		regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
> +
> +		break;
> +	default:
> +		dev_err(aml_dma->dma_device.dev, "status error\n");
> +		return NULL;
> +	}

Leave to Vinod Koul to do decide. This is not preferred implement to prep
tx descriptior.

> +
> +	if (sg_len > DMA_MAX_LINK) {
> +		dev_err(aml_dma->dma_device.dev,
> +			"maximum number of sg exceeded: %d > %d\n",
> +			sg_len, DMA_MAX_LINK);
> +		aml_chan->status = DMA_ERROR;
> +		return NULL;
> +	}
> +
> +	aml_chan->status = DMA_IN_PROGRESS;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		if (sg_dma_len(sg) > SG_MAX_LEN) {
> +			dev_err(aml_dma->dma_device.dev,
> +				"maximum bytes exceeded: %u > %lu\n",
> +				sg_dma_len(sg), SG_MAX_LEN);

why not split it and use mult sg_link to transfer it?
there are help functions sg_nents_for_dma()

> +			aml_chan->status = DMA_ERROR;
> +			return NULL;
> +		}
> +		sg_link = &aml_chan->sg_link[idx++];
> +		/* set dma address and len  to sglink*/
> +		sg_link->address = sg->dma_address;
> +		sg_link->ctl = FIELD_PREP(LINK_LEN, sg_dma_len(sg));
> +
> +		aml_chan->data_len += sg_dma_len(sg);
> +	}
> +	aml_chan->sg_link_cnt = idx;
> +
> +	return &aml_chan->desc;
> +}
> +
> +static int aml_dma_pause_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
> +	aml_chan->pre_status = aml_chan->status;
> +	aml_chan->status = DMA_PAUSED;
> +
> +	return 0;
> +}
> +
> +static int aml_dma_resume_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, 0);
> +	aml_chan->status = aml_chan->pre_status;
> +
> +	return 0;
> +}
> +
> +static int aml_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	int chan_id = aml_chan->chan_id;
> +
> +	aml_dma_pause_chan(chan);
> +	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> +
> +	if (aml_chan->direction == DMA_MEM_TO_DEV)
> +		regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), BIT(chan_id));
> +	else if (aml_chan->direction == DMA_DEV_TO_MEM)
> +		regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), BIT(chan_id));
> +
> +	aml_chan->status = DMA_COMPLETE;
> +
> +	return 0;
> +}
> +
> +static void aml_dma_enable_chan(struct dma_chan *chan)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	struct aml_dma_sg_link *sg_link;
> +	int chan_id = aml_chan->chan_id;
> +	int idx = aml_chan->sg_link_cnt - 1;
> +
> +	/* the last sg set eoc flag */
> +	sg_link = &aml_chan->sg_link[idx];
> +	sg_link->ctl |= LINK_EOC;
> +	if (aml_chan->direction == DMA_MEM_TO_DEV) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
> +			     aml_chan->sg_link_phys);
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_chan->data_len);
> +		regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), 0);
> +		/* for rch (tx) need set cfg 0 to trigger start */
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, 0);
> +	} else if (aml_chan->direction == DMA_DEV_TO_MEM) {
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR,
> +			     aml_chan->sg_link_phys);
> +		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_LEN, aml_chan->data_len);
> +		regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), 0);
> +	}
> +}
> +
> +static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
> +{
> +	struct aml_dma_dev *aml_dma = dev_id;
> +	struct aml_dma_chan *aml_chan;
> +	u32 done, eoc_done, err, err_l, end;
> +	int i = 0;
> +
> +	/* deal with rch normal complete and error */
> +	regmap_read(aml_dma->regmap, RCH_DONE, &done);
> +	regmap_read(aml_dma->regmap, RCH_ERR, &err);
> +	regmap_read(aml_dma->regmap, RCH_LEN_ERR, &err_l);
> +	err = err | err_l;
> +
> +	done = done | err;
> +
> +	while (done) {
> +		i = ffs(done) - 1;
> +		aml_chan = aml_dma->aml_rch[i];
> +		regmap_write(aml_dma->regmap, CLEAR_RCH, BIT(aml_chan->chan_id));
> +		if (!aml_chan) {
> +			dev_err(aml_dma->dma_device.dev, "idx %d rch not initialized\n", i);
> +			done &= ~BIT(i);
> +			continue;
> +		}
> +		aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
> +		dma_cookie_complete(&aml_chan->desc);
> +		dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
> +		done &= ~BIT(i);
> +	}
> +
> +	/* deal with wch normal complete and error */
> +	regmap_read(aml_dma->regmap, DMA_BATCH_END, &end);
> +	if (end)
> +		regmap_write(aml_dma->regmap, CLEAR_W_BATCH, end);
> +
> +	regmap_read(aml_dma->regmap, WCH_DONE, &done);
> +	regmap_read(aml_dma->regmap, WCH_EOC_DONE, &eoc_done);
> +	done = done | eoc_done;
> +
> +	regmap_read(aml_dma->regmap, WCH_ERR, &err);
> +	regmap_read(aml_dma->regmap, WDMA_RESP_ERR, &err_l);
> +	err = err | err_l;
> +
> +	done = done | err;
> +	i = 0;
> +	while (done) {
> +		i = ffs(done) - 1;
> +		aml_chan = aml_dma->aml_wch[i];
> +		regmap_write(aml_dma->regmap, CLEAR_WCH, BIT(aml_chan->chan_id));
> +		if (!aml_chan) {
> +			dev_err(aml_dma->dma_device.dev, "idx %d wch not initialized\n", i);
> +			done &= ~BIT(i);
> +			continue;
> +		}
> +		aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
> +		dma_cookie_complete(&aml_chan->desc);
> +		dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
> +		done &= ~BIT(i);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct dma_chan *aml_of_dma_xlate(struct of_phandle_args *dma_spec, struct of_dma *ofdma)
> +{
> +	struct aml_dma_dev *aml_dma = (struct aml_dma_dev *)ofdma->of_dma_data;
> +	struct aml_dma_chan *aml_chan = NULL;
> +	u32 type;
> +	u32 phy_chan_id;
> +
> +	if (dma_spec->args_count != 2)
> +		return NULL;
> +
> +	type = dma_spec->args[0];
> +	phy_chan_id = dma_spec->args[1];
> +
> +	if (phy_chan_id >= MAX_CHAN_ID)
> +		return NULL;
> +
> +	if (type == AML_DMA_TYPE_TX) {

This is DT ABI, should create header file in include/binding/dma

> +		aml_chan = aml_dma->aml_rch[phy_chan_id];
> +		if (!aml_chan) {
> +			if (aml_dma->chan_used >= aml_dma->chan_nr) {
> +				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
> +				return NULL;
> +			}
> +			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
> +			aml_dma->chan_used++;
> +			aml_chan->direction = DMA_MEM_TO_DEV;
> +			aml_chan->chan_id = phy_chan_id;
> +			aml_chan->reg_offs = RCH_REG_BASE + 0x40 * aml_chan->chan_id;
> +			aml_dma->aml_rch[phy_chan_id] = aml_chan;
> +		}
> +	} else if (type == AML_DMA_TYPE_RX) {
> +		aml_chan = aml_dma->aml_wch[phy_chan_id];
> +		if (!aml_chan) {
> +			if (aml_dma->chan_used >= aml_dma->chan_nr) {
> +				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
> +				return NULL;
> +			}
> +			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
> +			aml_dma->chan_used++;
> +			aml_chan->direction = DMA_DEV_TO_MEM;
> +			aml_chan->chan_id = phy_chan_id;
> +			aml_chan->reg_offs = WCH_REG_BASE + 0x40 * aml_chan->chan_id;
> +			aml_dma->aml_wch[phy_chan_id] = aml_chan;
> +		}
> +	} else {
> +		dev_err(aml_dma->dma_device.dev, "type %d not supported\n", type);
> +		return NULL;
> +	}
> +
> +	return dma_get_slave_channel(&aml_chan->chan);
> +}
> +
> +static int aml_dma_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct dma_device *dma_dev;
> +	struct aml_dma_dev *aml_dma;
> +	int ret, i, len;
> +	u32 chan_nr;
> +
> +	const struct regmap_config aml_regmap_config = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.max_register = 0x3000,
> +	};
> +
> +	ret = of_property_read_u32(np, "dma-channels", &chan_nr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
> +
> +	len = sizeof(*aml_dma) + sizeof(struct aml_dma_chan) * chan_nr;

use struct_size

> +	aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> +	if (!aml_dma)
> +		return -ENOMEM;
> +
> +	aml_dma->chan_nr = chan_nr;
> +
> +	aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(aml_dma->base))
> +		return PTR_ERR(aml_dma->base);
> +
> +	aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
> +						&aml_regmap_config);
> +	if (IS_ERR_OR_NULL(aml_dma->regmap))
> +		return PTR_ERR(aml_dma->regmap);
> +
> +	aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(aml_dma->clk))
> +		return PTR_ERR(aml_dma->clk);
> +
> +	aml_dma->irq = platform_get_irq(pdev, 0);
> +
> +	aml_dma->pdev = pdev;
> +	aml_dma->dma_device.dev = &pdev->dev;
> +
> +	dma_dev = &aml_dma->dma_device;
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	/* Initialize channel parameters */
> +	for (i = 0; i < chan_nr; i++) {
> +		struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
> +
> +		aml_chan->aml_dma = aml_dma;
> +		aml_chan->chan.device = &aml_dma->dma_device;
> +		dma_cookie_init(&aml_chan->chan);
> +
> +		/* Add the channel to aml_chan list */
> +		list_add_tail(&aml_chan->chan.device_node,
> +			      &aml_dma->dma_device.channels);
> +	}
> +	aml_dma->chan_used = 0;
> +
> +	dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
> +
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
> +	dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
> +	dma_dev->device_tx_status = aml_dma_tx_status;
> +	dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
> +
> +	dma_dev->device_pause = aml_dma_pause_chan;
> +	dma_dev->device_resume = aml_dma_resume_chan;
> +	dma_dev->device_terminate_all = aml_dma_terminate_all;
> +	dma_dev->device_issue_pending = aml_dma_enable_chan;
> +	/* PIO 4 bytes and I2C 1 byte */
> +	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +
> +	ret = dmaenginem_async_device_register(dma_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register dmaenginem\n");
> +
> +	ret = of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
> +	if (ret)
> +		return ret;

where call of_dma_controller_free() ?

Frank
> +
> +	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
> +	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
> +
> +	ret = devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), aml_dma);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to reqest_irq\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aml_dma_ids[] = {
> +	{ .compatible = "amlogic,a9-dma", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, aml_dma_ids);
> +
> +static struct platform_driver aml_dma_driver = {
> +	.probe = aml_dma_probe,
> +	.driver		= {
> +		.name	= "aml-dma",
> +		.of_match_table = aml_dma_ids,
> +	},
> +};
> +
> +module_platform_driver(aml_dma_driver);
> +
> +MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
> +MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.52.0
>

