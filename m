Return-Path: <dmaengine+bounces-1343-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A3879554
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 14:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092BF285AFD
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7207A708;
	Tue, 12 Mar 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCWzIPF/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0C67A704;
	Tue, 12 Mar 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251347; cv=none; b=aTn6qB6irCQIxK87JhlDsdP5m8jDxUuTHIAKSEHtn6qXQdLY+61gPS8dd6O3XgXUTPxV4mFXQCmUKQxfRXibP1lU26zFpSgXztCp3eTjf4qNblABDedXkA7Md5on0r+jgDD3gijsEAPR81qElww3GILFB+VY0BTM1iGfU/3zVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251347; c=relaxed/simple;
	bh=Wb92OThv6k4OLavfNWH6cZjJsriX0oW5ZwyOXvYtVpc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=YsbEo3jZFnWWUC2rS17kQGQ9SCvyfdYx6d8HKFyGAMQLwg+6aKIpQreI1xyxbVxTYUJsExwjD0KLdGwczzMRJbuX1jrFbuYMVDBqSoHZO1UAzr893N0uNT/3vUSdNwhkIMoCe9XlE3zX0dRkkFeJaEVsQSzjWnkFpm2brd7tTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCWzIPF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74B5C433F1;
	Tue, 12 Mar 2024 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710251346;
	bh=Wb92OThv6k4OLavfNWH6cZjJsriX0oW5ZwyOXvYtVpc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BCWzIPF/x07OIJgxoJPA8WS2i/Psr/uNcXF2ElWNLPkAB8/aV5LofDrBJRoXEXtkL
	 UGL++oYc4lWMDT/MkRrEFhJuErUOfURwiwWwyo1zO1xuJo6yEWJNKqMFujFnifXEiX
	 +Fkh5LRP5kU9N05xlw4Ko+dl3chuinVo1rcMG+zT5cRuP7v4qG6d98ETLJW7GrRcRH
	 z7j+on1s4kMek23RCMUr6EytNtzxUuuf/3Ey6ZcAdyT6pj5CsVjV34bNotJhHwwuED
	 dqR4CiZC2+Nuxh3QxKJDfjtwQ5e4JQ9oh4ytm5o74J22LSODlqKna9lQw2clC1CaUp
	 5bFUqdvngAIiA==
Date: Tue, 12 Mar 2024 07:49:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20240311222522.1939951-1-robh@kernel.org>
References: <20240311222522.1939951-1-robh@kernel.org>
Message-Id: <171025134347.2083269.1302794772701834117.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix
 data{-,_}width schema


On Mon, 11 Mar 2024 16:25:22 -0600, Rob Herring wrote:
> 'data-width' and 'data_width' properties are defined as arrays, but the
> schema is defined as a matrix. That works currently since everything gets
> decoded in to matrices, but that is internal to dtschema and could change.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/dma/snps,dma-spear1340.yaml      | 38 +++++++++----------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/snps,dma-spear1340.example.dtb: dma-controller@fc000000: data-width:0: [8, 8] is too short
	from schema $id: http://devicetree.org/schemas/dma/snps,dma-spear1340.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/snps,dma-spear1340.example.dtb: dma-controller@fc000000: Unevaluated properties are not allowed ('data-width' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/snps,dma-spear1340.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240311222522.1939951-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


