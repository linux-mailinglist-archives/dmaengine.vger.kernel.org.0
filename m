Return-Path: <dmaengine+bounces-9237-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPn5FsQTqGnUngAAu9opvQ
	(envelope-from <dmaengine+bounces-9237-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 12:13:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C31FEC8B
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 12:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2988303F5F4
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827423A7F7C;
	Wed,  4 Mar 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Di8uvvJ6"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58D3A5E87;
	Wed,  4 Mar 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622667; cv=fail; b=IBl0mgp07gY/3GLGG0SdVPmB+ZNXM6q84T+X4cOMM4slZBZHTl15Dg5NR2ve1xoPPpccy1UMh9cZc86SRo8bf1dxEf8lEi8oYRnIHV/7uTf+vz9Ezw4EIroYe/aw5C+7bcqWpPLEpONJF8OExqe3nF+MxTPwQIhsnDa9b3O8EqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622667; c=relaxed/simple;
	bh=rjJeEiAjF98nHgLvRllpYQt3DosQedD6VOlQgMeV5jY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AnjB34yKI/lrda1yjcUfnwjIcuNMEx0FVrxTQ+v23cL71ek67ncLAmbVViXklqK9QRUeP3DVRAPpUkMTQd2xGOFRUPaPISJvC1Pg2Bw/7vxu7gT2colD9QLbj6xfs8PUer0Q46+kLK2KxWc4szfVM0Y23IsGjOdLjLN1/WAlSEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Di8uvvJ6; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnzwzVxNmOTiKpriZjx5IC7Y919qeciHzOQfl11dkbfPD3+ThG9OEA99m3t6RLgeKOkryLSNgNAjy/ZvSVid4KKKuXL8WCKmOa+1qShZ3w+j+iILKICHSA3ciDPWOPugb9EECpTV6oXeoRKco8B0QCKhdOC/SzJLE7nszIrnRT9hprXXk0DByT13cBGjSHgKsMulE7OQ0hUdj4fXwcPZ5xDCiJ1nxZC8fRS7RLmg5QLkhb6n6xmw5l5mVl/+Ym8dYBnjQK0dUiRxf/d+EPb8wFavZe61AbFkZ2u9xu0jALHRdXNKQyCdvcedb0yp8fALYYDTv0Wtygd76AsSmzHYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV44EoIWGsb5Lofm/k8tDLR6zlj/mm9aIDH5oLWW6JM=;
 b=uqVXea4xRxpgrK417p349SphYXbAjS1gGEhlC0gPNQwdmHwjtbVx9svGcPKeZTdtRpMfhZUSg8SWm6zQJ5/po1n+xFd4U6wOLfyuQzVOWZ1FhgxsG6Va/ByF86X7+Z2gsLAo+Mh8LkqUQPzangvw6bJyTscPNWXeaLsGGsEdKz49nYLi2DlMvEl5cyLNuhjy0As0QigahcmB8FSCT6rMRzpx0gA8Q4ZB8iIe4A2jdb4WEryd/wz+g6StVECK7NpW2kcvlqvryNb1D+LQBv0XLhKwBDEPCx8NgPC3sIkBnKd0cxgtE7WjmRri7pgoqBOgh5zsLG+MUuISnhS7Z9rASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV44EoIWGsb5Lofm/k8tDLR6zlj/mm9aIDH5oLWW6JM=;
 b=Di8uvvJ6kcrg5YqlkVswBjAlHR4TkU9liK6bjwEoH9/vQHUBBfvZbCbLR/OvLYpsrbOG2ybHwiekBsiYqXchLYOXYfvpph7sVIL0m9Gwnp+9eDsTpVdVvcjt2ZG1CPjN6IUpQuL47/gZmc2Z6EtaqPmtbJ6vf6aShHM/7+cOk0leA3dNKFcgVjtzKoHlNE2Wf4gcPNOnPTaKdxN30xIeK0Y8QaEX3CcT+hzhE7YlamNRv9XpWViN6fM0mseTHZfoKjuocXALynUSUw5LZolYZ+oX+7bNQ5htmj+broTdQWaYYWbgQ/2iT2kJc+ACUsuHTg19DhuwaHWhPY7piI7fPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 11:11:01 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 11:11:01 +0000
Message-ID: <9740033b-0fa4-46c6-9628-f4c3ba1cceae@nvidia.com>
Date: Wed, 4 Mar 2026 11:10:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, krzk+dt@kernel.org, krzk@kernel.org,
 ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, p.zabel@pengutronix.de, robh@kernel.org,
 thierry.reding@kernel.org, vkoul@kernel.org
References: <361e0146-c5af-4f16-a946-14d1df85f99b@nvidia.com>
 <20260304103725.64228-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260304103725.64228-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0148.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::17) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f3e073-b9b0-4e89-35bc-08de79deb841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	EZbiSlcWM9svDeD0O61tCZS4C268bqk9sYTVt1JZvfSZtAswmUJOjdCwwJ/W2sXQ5LqeoL6aNc0G3OyPyqu+StabDs/AvI3oORLgjsxHKD2pum+bPyxjIYF45aLNpcAGSUzMuVS5wdgqMp6MHWJoKpPOMcwMJ41pvm6W1bcA/ne8yuDICcLy9brm7HqoVMfzKjxBZ9kvuaK1qino3DHloBX5sAkE4tK+J2a7Oc26hwY3d6oQgj0YO6lkSWokabHYumZyiYdA399jBn2vnH9BeFP8DrWyedLcWShm9IF/fLlILNT2aw7jy3e2RgxcJ2qqeMYixMyk2qXHbh4h3KjMpP3iSQUeXTDVY1wZgDqBcGSAAGhyCdEuDDOK2SmH+qB/Odu2aez9w/EnbdfGmRjRUX8ZyKsIi34y3ncscQ+SEjzC7J+Owb/TNwtwsnFXA0ffrkLary6f0mw9AFsnzxixKa5GHUYgi836QVwjMOlJc3AgaUtYgeVDIeClR8/YGzoCnO+/xULg1oScKnUt9/CqHb4fNhz35mTyE8KC4o2BbnFw2bY5256bL+qTXWFXh+Itjm0ocRRPRaeBKZgpf+c601EW+dQNhMQva13fXFpa09mnWoPGVPkSc/qe6HoRxdQjK2ppU1wHjB7PpwhVdJpd1SF2OLU6zXs+cgrQ4/2+k4rc4P++ql3Oefar1exkPGLsMlELA8+qDQRm9EjsAYoRkA0VyLJeAqcl6x4+0Rz2D8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmN5dEREbERNcGoyejhKaVNwWFBXZ3V0RnNMTFJnZ0Uwa2szUjVmemdjR21m?=
 =?utf-8?B?TTAxd2YwUkVOMmxTQkl4SDArN1AxdHlpdGh1T1d2a2xZOVBEQlhMNUt1ZGZY?=
 =?utf-8?B?bWtRRzFDNGFkWmFKaUJXRGpESHRYTVVtbFN0TEVNOWNyWmMyM2oyL2gwbmQy?=
 =?utf-8?B?QThiMFhzMjdBSU9sTjNCbC95TGNHcHhLT1RPZ1JVYkZ4ZHk0OWFoMTdBakgw?=
 =?utf-8?B?d28xRTdtMy9XVC9CcFNPQ0lPT3JwRWdTOENYR2VqTnFERFp3TWxBakxwOE9E?=
 =?utf-8?B?Z0NSOHRoVXZiS2YyS3Q4aWVoL0M2eTE5TDl1TE1Ja0FMSkNrRTF6Ulp3ZVZU?=
 =?utf-8?B?MHRqNERrMWs5UVdBVFlrQWhPY3pCUFhMT00vaVR6c210aFV6cjJUUXltQ2U3?=
 =?utf-8?B?cldaeDF1V1VJeHVOYXRPWlRXTUR5VWVtbWNMREpMdDM3ZTJWVzlxY0NQZlgy?=
 =?utf-8?B?cFhPcUlpQkRWSWlnZmp6aTRPTVE4a0w5RUVqR3VPV0k5V3h2L0dWOUJBWm9I?=
 =?utf-8?B?RHMvOWx2UE9CRXVnRzQ1Wng2OVZQUStnZ3dkcERubzlodXhqaEFTU2o2cktZ?=
 =?utf-8?B?ZkhnZkRXdnB2SU1CVkw3UGxHZ21yOVFlMlBwWWhYRU1pOW5uT3M5RXdjbklS?=
 =?utf-8?B?eEl5NDBWUWh0Nm1HUGtWY1kyUmVNUWhuTERSeXF4S1B0aVRsU2ZEcUdYaFU0?=
 =?utf-8?B?cXA1Y0tadHRmcjlqRXd5Ymlydi9HS2pWYmhWWGNFNi96N3lUT1U0bWdBL1VJ?=
 =?utf-8?B?V3VuWEFuNnkzMmYvU0tTc05kcmNUcTAxbEZHa0JBZGpoTGRpUm1CYWg4eHcw?=
 =?utf-8?B?UFJMazkyT011d3FhY1Jac05WSDdvQzFXNlA5MW05MmkxaUptYzMwbjhISnho?=
 =?utf-8?B?SCtVMUY0WEJVOXZERlI1emVUQU9jaWlQQ0taRHBXUHBEU2srTUFqYjhEZkxT?=
 =?utf-8?B?U24wajRlWC9saWZ2NnFQcWNqbmVTcmY2eGFsTFluRUt2YUhnOWRHbW92MFZ4?=
 =?utf-8?B?cVludkRDQmk4T3FwR0JTb1pHaVpLUEdrUkVJTkNCOStMN3E1dk5CejZsMFFw?=
 =?utf-8?B?cnhvT0FmbWhLMVFaMlo0Mkg2NGNsZFJ6Ny82aW1UemZOSDBhRmF1ZC9SdjhN?=
 =?utf-8?B?RDhQeExLRFdkWW52Tk9XdkpaRUV4TWlPY1Q5RjBEZkFUZVRMMWY0Z003Zm9Z?=
 =?utf-8?B?L3YxV25abHBOakRFU2ZuR1FjTE1QMVFVTmxKZno0OXdnTytrcVFBSVltbHdh?=
 =?utf-8?B?NVlQUmJLWDlJcW1sZUt6MEpOei9scHVOYXdlbFhKVXdVOFlWRjNpV3JFbTVQ?=
 =?utf-8?B?Y25jNExTTys4Um82L2N0L2Z0SEZDZ0s1dnBKeGlPRGx0Z3F5TllZNnNKQU1G?=
 =?utf-8?B?dGhPL0k3V0JHb0pOMS95QU9Gano0QnZIaHdzKzdrV0ZvdzRROXlHQWxOWFFC?=
 =?utf-8?B?OE84RkxQQzNsZCt6VysyWCt5cGxySE5uT1QyZnh0cHdpdUhtUEtBSVpCZStF?=
 =?utf-8?B?Zk9nUUR0Mk5CSW5SMWxpVjRCWnlCRSsxRmRHcjFWNVhVT3dOaVNBUEFFajNH?=
 =?utf-8?B?bzRkZmdpa1o2eDNqTmVNQy9uSGpyUENwKzhUUHRQckxPWHI4WHkrYXlSQm5w?=
 =?utf-8?B?aVlYQ2t5ZUgxbmJKMDU2c1NMOHdHUGxLWlNyWkgwS1BTMlkrcUhacHY0bWNB?=
 =?utf-8?B?QlJpeVh6elJCd2NSQm9UNWd5TC96SjdzU3lPbkIvK3FxN2hZWWRqc2dWakRw?=
 =?utf-8?B?MExNOWE2Qk83b2JtQXdncTJLaFdPbUkvTXdLaGU4dHhmRlBhYUJOVEpLSjRa?=
 =?utf-8?B?WitYQzQ2dXFpSEljanl5UU5wN1Q5RkQ5OVFwZTlWQklsbE1yS3BaMDE1S1Nr?=
 =?utf-8?B?MHd4S3l1UStDTS91SkdBc1U0U3NTcndYMGN6VzBoTnJMZ3BtRGM5U1duUkVq?=
 =?utf-8?B?M21DcG1YQ1hnU0RZR1Zwd2JnZkgvUnZzMkZGWTdUTTFvNUwxakloSnk1MXd5?=
 =?utf-8?B?YWlMQzVDRjZCNUNXNDNvQU5zNk1JL0hlTGNqaVNWTnNxZzlra3kwZVRlRzho?=
 =?utf-8?B?Nnd0YUo1NjBWYTcwc203aTd6WHdpUm5PWmExV2hSVEZnOFVGYmxXOXlnd1Ft?=
 =?utf-8?B?TTNtSG15MU5DY3lKem9QTGdRVWVHeGNlby9iNkUzTGlaR3ZoTkhDbW1KdzFJ?=
 =?utf-8?B?bmFESEdVTnZmWG5kYVh2Z3BNQzhtN1k3MEJqZ0JqcUVOU1pjQUJJcUVxTmdy?=
 =?utf-8?B?UThDNkh4bEkvUDFwNG1xVGlBY3FWT1dXZnNwTFB2VWwwTE5pNS93UW5uSzB0?=
 =?utf-8?B?cG8vN1RIeFgzUTUwN2ptOFVsb2FEeWRpaVhsMXZCT3FmUUFvWGowWjlwbVln?=
 =?utf-8?Q?tE/D4Ctbbv4Be9tdZuVN/C8UuUhlvDysbZJTvP+aTZkd7?=
X-MS-Exchange-AntiSpam-MessageData-1: Grb6tNM3+5IVng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f3e073-b9b0-4e89-35bc-08de79deb841
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 11:11:01.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CMSGzN56HYJix292Qf484jMVjd5/neh1PSQbS6j9LpGqaVI9KSRDxUBMd6ZcBj5rjEh3F7XC7k1FpdT3vX8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
X-Rspamd-Queue-Id: A19C31FEC8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9237-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 04/03/2026 10:37, Akhil R wrote:
> On Tue, 3 Mar 2026 17:34:00 +0000, Jon Hunter wrote:
>> On 03/03/2026 17:14, Akhil R wrote:
>>> On Tue, 3 Mar 2026 13:09:00 +0000, Jon Hunter wrote:
>>>> On 03/03/2026 08:40, Akhil R wrote:
>>>>
>>>> ...
>>>>
>>>>>> Why is this flexible? If it is, means usually items are distinctive, so
>>>>>> I would expect defining/listing them. If they are not distinctive,
>>>>>> commit msg is incorrect. If the list is as simple as 1-to-1 channel
>>>>>> mapping, just add it in the description how they are ordered.
>>>>>
>>>>> Yes, it is a 1-to-1 channel mapping to an IOMMU ID. The intent of making
>>>>> it flexible is to allow non-consecutive IOMMU ID assignments as well.
>>>>> This is particularly needed in virtualised environments where the
>>>>> hypervisor may reserve certain stream IDs, and the guest VM can map only
>>>>> the permitted ones. Shall I add a description here mentioning this
>>>>> use-case?
>>>>
>>>> Isn't this already handled by the 'dma-channel-mask' property? The
>>>> driver will skip over any channels that are not in specified by the mask.
>>>
>>> dma-channel-mask would not help if a channel is exposed, and the
>>> corresponding IOMMU ID is not exposed. For instance say channel 15 is
>> available for a VM, but not the stream ID 0x80f.
>>
>> Is that a valid configuration? Above we said it is a 1-to-1 mapping
>> which would imply the mapping is always constant. Ie. same channels maps
>> to name SID. Is that not the case?
> 
> I think the hypervisor configuration can determinte which stream IDs
> are assigned to each VM, so the mapping can vary across platforms.
> By 1-to-1, I meant that each channel maps to one IOMMU ID, but the
> specific IDs themselves may not be fixed. If we prefer a constant
> mapping instead, we could document that only IDs in the range 0x801 to
> 0x81f should be allocated to a Linux VM. Happy to go either way. Let me
> know your thoughts.

I guess I don't know what flexibility we need here. But the more 
flexible, the more complex the binding and so if we need that 
flexibility then you will need to look at how Qualcomm solved this for 
their 'iris video codec' as Krzysztof mentioned.

Jon

-- 
nvpublic


