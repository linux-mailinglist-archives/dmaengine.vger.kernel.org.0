Return-Path: <dmaengine+bounces-8513-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A47MdG5d2lGkgEAu9opvQ
	(envelope-from <dmaengine+bounces-8513-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 20:00:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6788C460
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3EB301C593
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11326D4CD;
	Mon, 26 Jan 2026 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EyoKr0A5"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863E2798EA;
	Mon, 26 Jan 2026 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454030; cv=fail; b=dD6uKunHzdWnZAzRyNbzdcxlgjITlxmKurGkVikNPx9AvQqkYcbutTkOCuL/LTyver+0AdJwJ28UmeMKbfCura6zvcCbfdeyooGgdhskxhZiWBiDljRE/LwiMn0Z2xOL1gE2NbUB+lv4Pd5yeNL1uaVc+VHiLNJ4JkVYteJpHjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454030; c=relaxed/simple;
	bh=tCFkFZbbqBNqpqMIiE7Br+dYvTsxZwifXhVDFHu2Zvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bDbBf1LF4u1BhBTxQbTwrru4LvCkfEVhTGIlT1+d0reGXm60vKezJlKXrcITO+SpeWSuHJdAexQP/myjKo8obupEdqDunU2I6vQXaYnk8H9nct+n2ROskliXaVKjzWc/o2Ym4U6P+5JT5aQtG6DY4p0XlwMhIulmkAqXEbLTwfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EyoKr0A5; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBpaEMm1F39yTbgV7+/SuIuxvCk/2T7dKlSkWhMtKHmNPYvkQ/uPHwAMsr1LhKRLuJ7FvKJ7vTVL0DaxuAioP+BIdPTVvQeqpAC75qIPXuqtA+FA6tUtYGxsomlULmCFsca6ISgv+VAW6M0rPJvsHoezpwbEN84q7umHcYQZ8vMg5rukQshEas4/FWHxFIwhMDgwVBG6dcSu6Llk9S4HRizMbL58XVBcrTqDDGvK5lOpVMQGYvFozEbgDGMNzYm4IfXlsPPw3LSMScEWEtitIxTY9e5FHyrWiO/qMYU561E+z/WvpShcqYZ6eOTKFGtTuX6rFGvWTjeMO+9YiRl4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg8yznrFGK/eloX0zF0yk8jnxcbD/zgvJPlysB8lWqI=;
 b=ZCr8oqmOs2H4HheqqV1P4ZqK/b+i4AYe0pC9MIL3vg93euzdLoj38jvJqkgiGkx7dmagXFLmmQiECUXQu2MrPbBNj91pmWx9XIoh1txWqxRFwOPVbZCWtA0r/iaRFibcMAiyLURhoOWmCUhsVERxPdC67fHBI05b3o+CkWtbuSHgreI+ahMPRerQAvZ60vnoUUkLCR9TOIzIwjC046OV5PCQ9bRh9F46kIG6Gs4qJIxAkx9xsaUwrCJoJVi9jwqJcQxcC7lgmppoQMexWf0kmMlGJ8lDo2sKCwLU0ABx7hqI9N2CtTz52kBL6xHBxWDe8zcgdQeCtnHHv9Rl7J+rQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg8yznrFGK/eloX0zF0yk8jnxcbD/zgvJPlysB8lWqI=;
 b=EyoKr0A5e9YIl6vvmT/MGBjYZZhYFXIj6Ta3wB/98crD7t7FWFF2kPH3kit9HtC4G9KIz4gacJ6DW4BVU1xr+8afgndtB6wJ80ZTyI1hyl0CazWnqYvKAI0sXepVcoZNUEcPUnRmUkANfFltt23VoPlH9Bx9honqRfiewOiuzQxvzBeD4B7rZEw8S104qTY8ePPaLpVfhCpPosNNxAJ737nrf+PqQexJR7x6wF/PD+GnrYfIV6Ve796TSkmOSt0TtLrCrL6OX1HrhPja/PnV/emTnnCzG95hPk10twQJez+gSJ+5BPd/BvK6cxRSyZ9Qz0JjtBZBd+tWl4CWnqzjHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10475.eurprd04.prod.outlook.com (2603:10a6:150:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 19:00:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Mon, 26 Jan 2026
 19:00:14 +0000
Date: Mon, 26 Jan 2026 14:00:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
 <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXEKeojreN06HIdF@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203BB877B64C4E525EC0269594A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB81203BB877B64C4E525EC0269594A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: PH8PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:510:23c::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10475:EE_
X-MS-Office365-Filtering-Correlation-Id: e4dc55c4-4e4d-48d5-d713-08de5d0d2328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fyb/VCC7Z/CxabPWEiMvCJudV3nrUNAOZ1baiCmhCoCIsXfWnocNdDy5KLdO?=
 =?us-ascii?Q?XACSIEUUZ7bpZw3UAU1tXfrEGdrGU5sBQuI/5TMmQ7H6Ch5Qhsw6QbA4kHw0?=
 =?us-ascii?Q?rlTGE9SonFa0zPqccpGwiN2OSevAzB+nk0ts6qa70rqtfubiKr9MZZoqiQor?=
 =?us-ascii?Q?6IAF/ou7GL8KVBd9YFnd+u/dqxYzSlfGugIvi4uKnX6wt7sNFk9D1W7okXjX?=
 =?us-ascii?Q?19CWllXsygS2BqfjFKRMDsst1qNIc69KOX2H1IEGfJ9YoXFrMYEVQ0OMIpT+?=
 =?us-ascii?Q?IIIjOUobQFfjwfTRxhAve97dE4zQZSWQ1xJoKnwzpheDSMPAfF7QUStXf/Rw?=
 =?us-ascii?Q?2gG1aKECYjmqI7vx/U9+hyDrDjHmUayIh5Qta9NtPL5fM5sfkgpSO2GLKdhL?=
 =?us-ascii?Q?mh7qN8N2voqH7XZT12bGmVDSADL0r0DDRC0BODe/4zFzobfBebU8o5Bjg6ZD?=
 =?us-ascii?Q?cWk4j6juyqnjcFTD1x2RtzXqtHkX7ULwQL32xLkLFKfNMpPgqnTF9KiZ+Wtz?=
 =?us-ascii?Q?DlUGPJvSay3R2dVcF6TXgrSUhmkeHTf3/9ZSQrG/DqIQhmA4XSJ5pmEh7mj+?=
 =?us-ascii?Q?DdfysNVewjasPNiVI8tLi2HOlEq8xj/QiiU7cQMjO9TIVFy3ctLKue1oVKX4?=
 =?us-ascii?Q?OeuyCWatx7zbnBBsECA6RCWc9itsG0FAIpMti+hgvQiL3GjgfnuxRY2/cTvJ?=
 =?us-ascii?Q?rPe8XcRkKJLtXGRcWk7kA2nqViVvxBCSl15qlFW4E5NMO7JNXl2jWJmS9WZ0?=
 =?us-ascii?Q?7c+ymjtvsSSRS6BsxPpMcGeyWZ73c1IHrQYqcs6NRB83ULrjJLSVY4CNeKNw?=
 =?us-ascii?Q?fSnkFMRTwsZiIgurw2AYYke4wN7XmzrKA9BqVz1oBp6EtBJIORkLxNx1k3Wg?=
 =?us-ascii?Q?5+eS66F3yLchiin0D3vjfS0ivUkMmWOVVbhruKWo2ENoRq3twdK6RxD9f5Ff?=
 =?us-ascii?Q?XQPzJhbJlURfyxQQnNoJWYBmvjgTBKvbbzE+lUE1t4XLk3xqTFZP9YrTKdqK?=
 =?us-ascii?Q?Nndfxfu4b+gjJW+YgijSq1EUDJZ98mbqT1URR20E0RSIdtid/mbFBj+BkRTt?=
 =?us-ascii?Q?j759HFMIXMDbJy0YkiR5D5TRxOCWWCLaDJyn/LSrMgIGHacv/v0/A6UZiQFn?=
 =?us-ascii?Q?8IuO5/nLuk0587VifNM9fYnH0eJkGsRHd1qYmYF0py2ovpaTbhgwRLuGMZZR?=
 =?us-ascii?Q?lZTpxXxJB2Denw1yc09tCwynzWVs0LbED+cBqQCxaZBQWCVm87GqJFdVVG4o?=
 =?us-ascii?Q?zJIoM/5n+HFXRaBS0YIse40k8Xhe47SX14V2uPDmOnMhsqxzn2mrKOtJs+Mv?=
 =?us-ascii?Q?kUI7G6UTusoat5l0t6+XnWpu0Z+xZRQH/IW5PrYBtTrS3QfBBuA7gSej+yKj?=
 =?us-ascii?Q?Jp0xL2+X2dP/RdOnAV3IiQx0nlfb+aAbPCZPl1J5aIImQY0lKQSqJItf2jYY?=
 =?us-ascii?Q?YP916rROKmmlbGpDU1Ixz0GU+ubMEBnyaFJYhn3FOQM4yb56hEZ4WiF/G2Pg?=
 =?us-ascii?Q?Kx9J3ZUJNONdl1x1YcLu0xkBmHQYLqWpD1JjUi7gjZDjqHAfPg3pEKWe30II?=
 =?us-ascii?Q?PjZ10/Wyf2y6tSYviiQVHm1Or8quJOlSYwMHt65OlSXxwg0zv034uNhEiAxH?=
 =?us-ascii?Q?JZUyjlBBuYd2+01NRu2kD+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V0gnZtPbZzhOWnDMmtUk4PgRAtao6Kyp1BZm4EWW5r7P+d5dR22aU82PdkFk?=
 =?us-ascii?Q?jKq7ejJF9emUtyh93LPz0HeIQ20HtFtY0E1UQZjge+6HcT9QPtd8w6OQZo44?=
 =?us-ascii?Q?ONlEyfwf1Wx4Xp+ldln2QtnzAy2M+F/wcBZKmbAdjBBYta4fdTyae/xjemco?=
 =?us-ascii?Q?6uP03F8P9ND/Qbq0xNGiJgBzqb24CPbd3ukFMn4wT8S1fCkFZ1U5kzR2zW9Z?=
 =?us-ascii?Q?6ID1ijD8d4L9yS7klSk2WsAcmc8+DbFe5jDQ9AhS26pFkrjLtB5S/hJDAhdI?=
 =?us-ascii?Q?/XFnC/cN8E01ZRzsrYVQ3J/pyA53RZzJUqhvHqy5D0LbJFvBZNF90LfbrZXS?=
 =?us-ascii?Q?catTgz509Ozrwa16O1d5WMgMSluvbbI/EgL9XOP4IL45O20iNHX6deqZaU2Z?=
 =?us-ascii?Q?GU8+irA7FOHc5urzD0qWdtlX2QG2ueN9DWuj9ZTbwXXg9BYGZqMS3/mOj9/B?=
 =?us-ascii?Q?wq7tAxm5OdbN5uOleFCOGP5kWObd8cQHAqjCllAxmTbadoM0WjKh87XlXQIo?=
 =?us-ascii?Q?71gz0eDAjFXzCxfnBkqx39bwon7n3cwOcn7YJtfIZw0GC/tKh3HVpWsBBun7?=
 =?us-ascii?Q?kM88o8tbc/uo/ANm6wU7Ru31XcZUP21W6U4TRJLNCX4hH6FI2EAoll6r2FP6?=
 =?us-ascii?Q?D92qUQWh9SbTA1gcB+H3GR5UU+XjiffWulTq6Du1eXKw8sb4qo5MfXbaiFc+?=
 =?us-ascii?Q?moIcDBmtXsfbDEkXacBUcl3AFwdp60/mmbecwzfbfqSEIytGN+PbBCB9eOjN?=
 =?us-ascii?Q?0f6ZmVhszGcxAmeeNcmgVMylvyCZ+sFH77st+NGyv8tp+jdcK2WVBEwxQHGT?=
 =?us-ascii?Q?tErjptrEBhUlgXlI90xmOu5LIDA8qxrn52Lf2W8q+s8Lr3z8nauSKmDo+zrv?=
 =?us-ascii?Q?8liD0PgWlhiGW0ghiypuKlmdCU74KSblmbzzl5iH3/BTpsRSxPrPEZXOq/6r?=
 =?us-ascii?Q?ET21pc71YpZ4W5XNhg0OkUctDl8Ak5Wes97q8qgp9XdrkWXeZFbx4GOyfXEB?=
 =?us-ascii?Q?fTFGLBRQ+q9ZlxHVqLaXxCO950IIEgEKW4i8oa4cOF7SUMjR/JRAwzpTQoAW?=
 =?us-ascii?Q?AiRvkF+2FrSLa+zCO2Ram2k9nDpaTKDgrOx84zAA7EM7Zc6E8l10ZLpY1Twp?=
 =?us-ascii?Q?7jNJbfI3SOtrY35tyqZl0krp7rHK53od2pftSj9/mCTNEQ5L1OP4t5+Xp7UJ?=
 =?us-ascii?Q?Q/Wbu1Wo4lSx5vHG/+yswIuriO1Vj6xv4FjCBKCFCa9qcUELl6JTTJbMQ5Jr?=
 =?us-ascii?Q?FtwBxkyIKWM5b4jY0SNmDVk3QF6ecBgPJcONxEgBWlOZYQl/iFYHciRkb79s?=
 =?us-ascii?Q?wQP5oDiwcnVxLVdcVJcr1vR7WGAYDVoK4TF1j//Uy5Qm0cWHEP6iBmyXnGqd?=
 =?us-ascii?Q?YbfNnMpwRkaOLfqQlUvOtwW+2mtRzuB6Kf3woVMah/59bHaI3VG6A6jn1Ms1?=
 =?us-ascii?Q?4OuZ2kx3hZJx3bjULxLacjZ6/6reNJPHzGU40UHmg2o91ILdWLtZZYFTQ0kz?=
 =?us-ascii?Q?lchJgBuZwOsdTQFonEXSaVUJvw0zwtqQJaIKdyLlwpH94kcOOuzsXGMoRwaa?=
 =?us-ascii?Q?GWaF1UvF/95vZ2CeyiHybP2ykxVw+7N/od0GWwj3a4hmnqVIRD4Ur+LU6QW1?=
 =?us-ascii?Q?uqNDHgL2hWz5ZI21QCsIK9fETbqhTmSH9knxRkxMDO42UIFjv6nPLWiCLmp5?=
 =?us-ascii?Q?4QUwuxXFtXFH/3AaISxp/oN1b0SrVmj5ZCrFaCrDITjvJQmJoxHv+Xf+hLTS?=
 =?us-ascii?Q?oe4QxMLgtg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dc55c4-4e4d-48d5-d713-08de5d0d2328
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 19:00:14.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlhDxgNa7qH7qth3SzdtuD+gr5WIdYjEUgvCUvFlGpST7g4AJa1q0ojpPAQD3whaec1L5G/w+pfVd9vKSsgBtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10475
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8513-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 3D6788C460
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:26:15PM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Wednesday, January 21, 2026 10:49 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
>
> --[ Snipped some headers to reduce the size of this mail ]--
>
> > > > > >
> > > > > > On Fri, Jan 09, 2026 at 05:33:54PM +0530, Devendra K Verma wrote:
> > > > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > > > > The current code does not have the mechanisms to enable the
> > > > > > > DMA transactions using the non-LL mode. The following two
> > > > > > > cases are added with this patch:
> > > > > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > > > > >   the device side DDR is not configured, then the IP can still be
> > > > > > >   used in non-LL mode. For all the channels DMA transactions
> > > > > > > will
> > > > > >
> > > > > > If DDR have not configured, where DATA send to in device side by
> > > > > > non-LL mode.
> > > > > >
> > > > >
> > > > > The DDR base address in the VSEC capability is used for driving
> > > > > the DMA transfers when used in the LL mode. The DDR is configured
> > > > > and present all the time but the DMA PCIe driver uses this DDR
> > > > > base address (physical address) to configure the LLP address.
> > > > >
> > > > > In the scenario, where this DDR base address in VSEC capability is
> > > > > not configured then the current controller cannot be used as the
> > > > > default mode supported is LL mode only. In order to make the
> > > > > controller usable non-LL mode is being added which just needs SAR,
> > > > > DAR, XFERLEN and control register to initiate the transfer. So,
> > > > > the DDR is always present, but the DMA PCIe driver need to know
> > > > > the DDR base physical address to make the transfer. This is useful
> > > > > in scenarios where the memory
> > > > allocated for LL can be used for DMA transactions as well.
> > > >
> > > > Do you means use DMA transfer LL's context?
> > > >
> > >
> > > Yes, the device side memory reserved for the link list to store the
> > > descriptors, accessed by the host via BAR_2 in this driver code.
> > >
> > > > >
> > > > > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > > > > >   is not applicable for Synopsys IP with the current code addition.
> > > > > > >
> > > > > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > > > > > >   and if user wants to use non-LL mode then user can do so via
> > > > > > >   configuring the peripheral_config param of dma_slave_config.
> > > > > > >
> > > > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > > > ---
> > > > > > > Changes in v8
> > > > > > >   Cosmetic change related to comment and code.
> > > > > > >
> > > > > > > Changes in v7
> > > > > > >   No change
> > > > > > >
> > > > > > > Changes in v6
> > > > > > >   Gave definition to bits used for channel configuration.
> > > > > > >   Removed the comment related to doorbell.
> > > > > > >
> > > > > > > Changes in v5
> > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > >   In the dw_edma_device_config() WARN_ON replaced with
> > dev_err().
> > > > > > >   Comments follow the 80-column guideline.
> > > > > > >
> > > > > > > Changes in v4
> > > > > > >   No change
> > > > > > >
> > > > > > > Changes in v3
> > > > > > >   No change
> > > > > > >
> > > > > > > Changes in v2
> > > > > > >   Reverted the function return type to u64 for
> > > > > > >   dw_edma_get_phys_addr().
> > > > > > >
> > > > > > > Changes in v1
> > > > > > >   Changed the function return type for dw_edma_get_phys_addr().
> > > > > > >   Corrected the typo raised in review.
> > > > > > > ---
> > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> > > > +++++++++++++++++++++---
> > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46
> > ++++++++++++++++++--
> > > > ------
> > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > > > > ++++++++++++++++++++++++++++++++++-
> > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > > > > >
> > > > > > edma-v0-core.c have not update, if don't support, at least need
> > > > > > return failure at dw_edma_device_config() when backend is eDMA.
> > > > > >
> > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > index b43255f..d37112b 100644
> > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > @@ -223,8 +223,32 @@ static int dw_edma_device_config(struct
> > > > > > dma_chan *dchan,
> > > > > > >                                struct dma_slave_config *config)  {
> > > > > > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > > > > +     int non_ll = 0;
> > > > > > > +
> > > > > > > +     if (config->peripheral_config &&
> > > > > > > +         config->peripheral_size != sizeof(int)) {
> > > > > > > +             dev_err(dchan->device->dev,
> > > > > > > +                     "config param peripheral size mismatch\n");
> > > > > > > +             return -EINVAL;
> > > > > > > +     }
> > > > > > >
> > > > > > >       memcpy(&chan->config, config, sizeof(*config));
> > > > > > > +
> > > > > > > +     /*
> > > > > > > +      * When there is no valid LLP base address available then the
> > default
> > > > > > > +      * DMA ops will use the non-LL mode.
> > > > > > > +      *
> > > > > > > +      * Cases where LL mode is enabled and client wants to use the
> > non-LL
> > > > > > > +      * mode then also client can do so via providing the
> > peripheral_config
> > > > > > > +      * param.
> > > > > > > +      */
> > > > > > > +     if (config->peripheral_config)
> > > > > > > +             non_ll = *(int *)config->peripheral_config;
> > > > > > > +
> > > > > > > +     chan->non_ll = false;
> > > > > > > +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll &&
> > non_ll))
> > > > > > > +             chan->non_ll = true;
> > > > > > > +
> > > > > > >       chan->configured = true;
> > > > > > >
> > > > > > >       return 0;
> > > > > > > @@ -353,7 +377,7 @@ static void
> > > > > > > dw_edma_device_issue_pending(struct
> > > > > > dma_chan *dchan)
> > > > > > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer-
> > >dchan);
> > > > > > >       enum dma_transfer_direction dir = xfer->direction;
> > > > > > >       struct scatterlist *sg = NULL;
> > > > > > > -     struct dw_edma_chunk *chunk;
> > > > > > > +     struct dw_edma_chunk *chunk = NULL;
> > > > > > >       struct dw_edma_burst *burst;
> > > > > > >       struct dw_edma_desc *desc;
> > > > > > >       u64 src_addr, dst_addr;
> > > > > > > @@ -419,9 +443,11 @@ static void
> > > > > > > dw_edma_device_issue_pending(struct
> > > > > > dma_chan *dchan)
> > > > > > >       if (unlikely(!desc))
> > > > > > >               goto err_alloc;
> > > > > > >
> > > > > > > -     chunk = dw_edma_alloc_chunk(desc);
> > > > > > > -     if (unlikely(!chunk))
> > > > > > > -             goto err_alloc;
> > > > > > > +     if (!chan->non_ll) {
> > > > > > > +             chunk = dw_edma_alloc_chunk(desc);
> > > > > > > +             if (unlikely(!chunk))
> > > > > > > +                     goto err_alloc;
> > > > > > > +     }
> > > > > >
> > > > > > non_ll is the same as ll_max = 1. (or 2, there are link back entry).
> > > > > >
> > > > > > If you set ll_max = 1, needn't change this code.
> > > > > >
> > > > >
> > > > > The ll_max is defined for the session till the driver is loaded in the
> > kernel.
> > > > > This code also enables the non-LL mode dynamically upon input from
> > > > > the DMA client. In this scenario, touching ll_max would not be a
> > > > > good idea as the ll_max controls the LL entries for all the DMA
> > > > > channels not just for a single DMA transaction.
> > > >
> > > > You can use new variable, such as ll_avail.
> > > >
> > >
> > > In order to separate out the execution paths a new meaningful variable
> > "non_ll"
> > > is used. The variable "non_ll" alone is sufficient. Using another
> > > variable along side "non_ll" for the similar purpose may not have any
> > added advantage.
> >
> > ll_avail can help debug/fine tune how much impact preformance by adjust ll
> > length. And it make code logic clean and consistent. also ll_avail can help test
> > corner case when ll item small. Normall case it is hard to reach ll_max.
> >
>
> Thank you for your suggestion. The ll_max is max limit on the descriptors that can
> be accommodated on the device side DDR. The ll_avail will always be less than ll_max.
> The optimization being referred can be tried without even having to declare the ll_avail
> cause the number of descriptors given can be controlled by the DMA client based on the length
> argument to the dmaengine_prep_* APIs.

I optimzied it to allow dynatmic appended dma descriptors.

https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/T/#t

> So, the use of dynamic ll_avail is not necessarily
> required. Without increasing the ll_max, ll_avail cannot be increased. In order to increase
> ll_max one may need to alter size and recompile this driver.
>
> However, the requirement of ll_avail does not help for the supporting the non-LL mode.
> For non-LL mode to use:
> 1) Either LL mode shall be not available, as it can happen for the Xilinx IP.
> 2) User provides the preference for non-LL mode.
> For both above, the function calls are different which can be differentiated by using
> the "non_ll" flag. So, even if I try to accommodate ll_avail, the call for LL or non-LL would be
> ambiguous as in case of LL mode also we can have a single descriptor as similar to non-LL mode.
> Please check the function dw_hdma_v0_core_start() in this review where the decision is taken
> Based on non_ll flag.

We can treat ll_avail == 1 as no_ll mode because needn't set extra LL in
memory at all.

>
> > >
> > > > >
> > > > > > >
> > ...
> > > > > > > +
> > > > > > > + ll_block->bar);
> > > > > >
> > > > > > This change need do prepare patch, which only change
> > > > > > pci_bus_address() to dw_edma_get_phys_addr().
> > > > > >
> > > > >
> > > > > This is not clear.
> > > >
> > > > why not. only trivial add helper patch, which help reviewer
> > > >
> > >
> > > I was not clear on the question you asked.
> > > It does not look justified when a patch is raised alone just to replace this
> > function.
> > > The function change is required cause the same code *can* support
> > > different IPs from different vendors. And, with this single change
> > > alone in the code the support for another IP is added. That's why it
> > > is easier to get the reason for the change in the function name and syntax.
> >
> > Add replace pci_bus_address() with dw_edma_get_phys_addr() to make
> > review easily and get ack for such replacement patches.
> >
> > two patches
> > patch1, just replace exist pci_bus_address() with dw_edma_get_phys_addr()
> > patch2, add new logic in dw_edma_get_phys_addr() to support new vendor.
> >
>
> I understand your concern about making the review easier. However, given that
> we've been iterating on this patch series since September and are now at v9,
> I believe the current approach is justified. The function renames from
> pci_bus_address() to dw_edma_get_phys_addr() is directly tied to the
> non-LL mode functionality being added - it's needed because the same code
> now supports different IPs from different vendors.
>
> Splitting this into a separate preparatory patch at this stage would further
> delay the review process. The change is kind of straightforward and the context is clear
> within the current patch. I request you to review this patch to avoid additional review cycles.
>
> This also increases the work related to testing and maintaining multiple patches.
> I have commitment for delivery of this, and I can see adding one more series definitely
> add 3-4 months of review cycle from here. Please excuse me but this code has already

Thank you for your persevere.

> been reviewed extensively by other reviewers and almost by you as well. You can check
> the detailed discussion wrt this function at the following link:
> https://lore.kernel.org/all/SA1PR12MB8120341DFFD56D90EAD70EDE9514A@SA1PR12MB8120.namprd12.prod.outlook.com/
>

But still not got reviewed by tags. The recently,  Manivannan Sadhasivam
, Niklas Cassel and me active worked on this driver. You'd better to get
their feedback. Bjorn as pci maintainer to provide generally feedback.


> > >
> > > > >
> > > > > > >               ll_region->paddr += ll_block->off;
> > > > > > >               ll_region->sz = ll_block->sz;
> > > > > > >
> > ...
> > > > > > >
> > > > > > > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> > > > > > *chunk)
> > > > > > > +{
> > > > > > > +     struct dw_edma_chan *chan = chunk->chan;
> > > > > > > +     struct dw_edma *dw = chan->dw;
> > > > > > > +     struct dw_edma_burst *child;
> > > > > > > +     u32 val;
> > > > > > > +
> > > > > > > +     list_for_each_entry(child, &chunk->burst->list, list) {
> > > > > >
> > > > > > why need iterated list, it doesn't support ll. Need wait for irq
> > > > > > to start next
> > > > one.
> > > > > >
> > > > > > Frank
> > > > >
> > > > > Yes, this is true. The format is kept similar to LL mode.
> > > >
> > > > Just fill one. list_for_each_entry() cause confuse.
> > > >
> > > > Frank
> > >
> > > I see, we can use list_first_entry_or_null() which is dependent on
> > > giving the type of pointer, compared to this list_for_each_entry()
> > > looks neat and agnostic to the pointer type being used. Though, it can be
> > explored further.
> > > Also, when the chunk is allocated, the comment clearly spells out how
> > > the allocation would be for the non LL mode so it is evident that each
> > > chunk would have single entry and with that understanding it is clear
> > > that loop will also be used in a similar manner, to retrieve a single
> > > entry. It is a similar use case as of "do {}while (0)" albeit needs a context to
> > understand it.
> >
> > I don't think so. list_for_each_entry() is miss leading to reader think it is not
> > only to one item in burst list, and use polling method to to finish many burst
> > transfer.
> >
> > list_for_each_entry() {
> >         ...
> >         readl_timeout()
> > }
> >
> > Generally, EDMA is very quick, polling is much quicker than irq if data is small.
> >
> > Frank
> >
>
> The polling is not required. The single burst will raise the interrupt and from the
> interrupt context another chunk will be scheduled. This cycle repeats till all the chunks
> with single burst are exhausted.
>
> The following comment made in function dw_edma_device_transfer() in the same patch
> makes it amply clear that only a single burst would be handled for the non-LL mode.
> +       /*
> +        * For non-LL mode, only a single burst can be handled
> +        * in a single chunk unlike LL mode where multiple bursts
> +        * can be configured in a single chunk.
> +        */
>
> Looking at the way bursts are appended to chunks and chunks in dw_edma_device_transfer()
> are scheduled for non-LL mode then it is clear what non-LL mode would handle in terms of bursts.
> I just kept the format to match it with the LL mode format otherwise there is no
> need of this comment and we can follow the syntax for a single entry alone.
> Please share your suggestion if these descriptions fail to provide the clear context and intent.

Avoid use list_for_each_entry() here to prevent miss-leading.

Frank

>
> > >
> > > > >
> > > > > >
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> > > > > > > + HDMA_V0_CH_EN);
> > > > > > > +
> > > > > > > +             /* Source address */
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > > > > > > +                       lower_32_bits(child->sar));
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > > > > > +                       upper_32_bits(child->sar));
> > > > > > > +
> > > > > > > +             /* Destination address */
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > > > > > > +                       lower_32_bits(child->dar));
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > > > > > +                       upper_32_bits(child->dar));
> > > > > > > +
> > > > > > > +             /* Transfer size */
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > + transfer_size,
> > > > > > > + child->sz);
> > > > > > > +
> > > > > > > +             /* Interrupt setup */
> > > > > > > +             val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > > > > > > +                             HDMA_V0_STOP_INT_MASK |
> > > > > > > +                             HDMA_V0_ABORT_INT_MASK |
> > > > > > > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > > > > > > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > > > > +
> > > > > > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > > > > > > +                     val |= HDMA_V0_REMOTE_STOP_INT_EN |
> > > > > > > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > > > > > > +             }
> > > > > > > +
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, int_setup,
> > > > > > > + val);
> > > > > > > +
> > > > > > > +             /* Channel control setup */
> > > > > > > +             val = GET_CH_32(dw, chan->dir, chan->id, control1);
> > > > > > > +             val &= ~HDMA_V0_LINKLIST_EN;
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, control1,
> > > > > > > + val);
> > > > > > > +
> > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > > > > > +                       HDMA_V0_DOORBELL_START);
> > > > > > > +     }
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk
> > > > > > > +*chunk, bool
> > > > > > > +first) {
> > > > > > > +     struct dw_edma_chan *chan = chunk->chan;
> > > > > > > +
> > > > > > > +     if (chan->non_ll)
> > > > > > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > > > > > +     else
> > > > > > > +             dw_hdma_v0_core_ll_start(chunk, first); }
> > > > > > > +
> > > > > > >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan
> > > > > > > *chan)
> > > > {
> > > > > > >       struct dw_edma *dw = chan->dw; diff --git
> > > > > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > index eab5fd7..7759ba9 100644
> > > > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > @@ -12,6 +12,7 @@
> > > > > > >  #include <linux/dmaengine.h>
> > > > > > >
> > > > > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > > > > +#define HDMA_V0_CH_EN                                BIT(0)
> > > > > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > > > > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > > > > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > b/include/linux/dma/edma.h index 3080747..78ce31b 100644
> > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > >       enum dw_edma_map_format mf;
> > > > > > >
> > > > > > >       struct dw_edma          *dw;
> > > > > > > +     bool                    non_ll;
> > > > > > >  };
> > > > > > >
> > > > > > >  /* Export to the platform drivers */
> > > > > > > --
> > > > > > > 1.8.3.1
> > > > > > >

