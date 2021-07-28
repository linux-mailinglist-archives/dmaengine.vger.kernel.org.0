Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4973D8898
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhG1HLG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 03:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhG1HLF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 03:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77D0060F01;
        Wed, 28 Jul 2021 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627456264;
        bh=IhIVtvRnwRzmU31C2d2nJk+jPk0BLkDZxbZYsO6MUwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vO3p1dtD1rl80Fd5hhhEp5zF98whoYh71tm37X/GWc/XI7gcS05VtK7lDsCo+ZEuP
         iJLnT6G+OAQKMJlaCn9AztTw7APQvZ2Qk+H1oJD1h7ADs/BO/cf28R/oAZI/oQEAzX
         Torhqa+lhumXvJY2SN6WK38AmPcb6F+0gWKKVIThxzaBLDS5J3IcxxfIvYZT0WUgLb
         wmtqyjmm/2i4fKXgsTSXxeGwAyAio9wStoSs7OxLdxJDSQS+879O88O9LnVk9yb47l
         6ACf1nXoRmDXUg75IEbF6BO8pN2Cp3sOMHrdZBYbNeBFAz2SaezHL8Y/XrzTI/V96Q
         qZE/1MGBe37fg==
Date:   Wed, 28 Jul 2021 12:41:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     krzk@kernel.org, allen.lkml@gmail.com, romain.perier@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] ppc4xx: replace sscanf() by kstrtoul()
Message-ID: <YQEDBN77zwBIIltt@matsya>
References: <20210710165432.GA690401@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710165432.GA690401@pc>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-07-21, 17:54, Salah Triki wrote:
> Fix the checkpatch.pl warning: "Prefer kstrto<type> to single variable sscanf".

Applied, thanks

-- 
~Vinod
